class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
  end

  def users
    @users = User.all
  end

  def user
    @user = User.find_by(id: params[:id])
    redirect_to admin_users_path, warning: "Brak takiego użytkownika" unless @user
  end

  def games
    @plays = Play.active
  end

  def archived_games
    @plays = Play.done
  end

  def settings
    if Setting.any?
      @settings = Setting.first
    else
      @settings = Setting.new
      @settings.save
    end
  end

  def update_settings
    if Setting.first&.update(settings_params)
      redirect_to admin_settings_path, notice: "Ustawienia zostały zapisane"
    else
      redirect_to admin_settings_path, alert: "Coś poszło nie tak"
    end
  end

  def changes
    @changes = ChangeProposal.to_check
  end

  def archived_changes
    @changes = ChangeProposal.checked
    render "changes", locals: { show_archived: true }
  end

  def change
    @proposal = ChangeProposal.find_by(id: params[:id])
    @event = @proposal&.event
  end

  def implement_change
    @proposal = ChangeProposal.find_by(id: params[:id])
    @event = @proposal.event
    if @proposal.update(change_params)
      @proposal.implement
      redirect_to admin_changes_path, notice: "Pomyślnie wdrożono zmianę."
    else
      render :change, status: :unprocessable_entity
    end
  end

  def not_implement_change
    @proposal = ChangeProposal.find_by(id: params[:id])
    @proposal.not_implement
    redirect_to admin_changes_path, notice: "Oznaczono propozycję jako nie wdrożoną."
  end

  private

  def settings_params
    params.require(:setting).permit(
      :regulations,
      :information_on_the_processing_of_personal_data,
      :defeat_description,
      :subjected_description,
      :how_to_play,
      :contact,
      social_satisfaction_levels: [ :threshold, :text ]
    )
  end

  def change_params
    params.require(:change_proposal).permit(:content, :event_id, :title, :description, :positive_description, :negative_description, :budget_name, :budget_change, :is_adding_to_budget, :budget_reserve_change, :need_increase_budget_reserve, :region, :frequency)
  end
end
