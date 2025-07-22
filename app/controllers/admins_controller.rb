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

  private

  def settings_params
    params.require(:setting).permit(
      :regulations,
      :information_on_the_processing_of_personal_data,
      social_satisfaction_levels: [ :threshold, :text ]
    )
  end
end
