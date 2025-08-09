class ChangesController < ApplicationController
  before_action :check_tester_status

  def index
    @events = Event.all
  end

  def info; end

  def show
    @event = Event.find(params[:id])
    @proposal = ChangeProposal.build(@event.attributes.except("id"))
    @proposal.is_adding_new_event = false
  end

  def create
    if params.dig(:change_proposal, :event_id)
      @proposal = ChangeProposal.build(change_params)
      @event = @proposal.event
      @proposal.user = current_user
      if @proposal.save
        redirect_to changes_path, notice: "Dodano propozycję zmiany"
      else
        render :show, status: :unprocessable_entity
      end
    elsif params.dig(:change_proposal, :is_adding_new_event) == "true"
      @proposal = ChangeProposal.build(change_params)
      @proposal.user = current_user
      if @proposal.save
        redirect_to changes_path, notice: "Dodano propozycję zmiany"
      else
        render :new, status: :unprocessable_entity
      end
    else
      @proposal = ChangeProposal.build(single_change_params)
      @proposal.user = current_user
      if @proposal.save
        redirect_to changes_path, notice: "Dodano propozycję zmiany"
      else
        redirect_to changes_path, alert: "Nie udało się dodać propozycji zmiany"
      end
    end
  end

  def new
    @proposal = ChangeProposal.new(is_adding_new_event: true)
  end

  private

  def check_tester_status
    redirect_to root_path, notice: "Nie masz uprawnień testera" unless current_user&.allowed_to_test?
  end

  def change_params
    params.require(:change_proposal).permit(:content, :event_id, :title, :description, :positive_description, :negative_description, :budget_name, :budget_change, :is_adding_to_budget, :budget_reserve_change, :need_increase_budget_reserve, :region, :frequency, :is_adding_new_event, :negative_title, :positive_title)
  end

  def single_change_params
    params.require(:change_proposal).permit(:content)
  end
end
