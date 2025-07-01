class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.create(event_params)
    if @event.save
      redirect_to admin_events_path, notice: "Wydarzenie zostało stworzone."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to admin_events_path, notice: "Wydarzenie zostało zaktulaizowane."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params[:event].permit(:title, :description, :positive_description, :negative_description, :budget_name, :budget_change, :is_adding_to_budget, :budget_reserve_change, :need_increase_budget_reserve, :region, :frequency)
  end
end
