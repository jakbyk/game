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

  def contacts
    @contacts = ContactMessage.to_read
  end

  def archived_contacts
    @contacts = ContactMessage.readed
  end

  def contact
    @contact = ContactMessage.find_by(id: params[:id])
    redirect_to admin_contacts_path, warning: "Nie znaleziono takiej wiadomości" unless @contact
  end

  def mark_readed
    if ContactMessage.find_by(id: params[:id]).update(is_read: true)
      return redirect_to admin_contact_path(id: params[:id]), notice: "Oznaczono wiadomość jako przeczytaną"
    end
    redirect_to admin_contacts_path, warning: "Coś poszło nie tak"
  end

  def mark_un_readed
    if ContactMessage.find_by(id: params[:id]).update(is_read: false)
      return redirect_to admin_contact_path(id: params[:id]), notice: "Oznaczono wiadomość jako nie przeczytaną"
    end
    redirect_to admin_contacts_path, warning: "Coś poszło nie tak"
  end

  def make_response
    resp = ContactMessage.find_by(id: params[:id]).responses.new(message: params.dig(:response, :message), user: current_user)
    if resp.save
      ContactMailer.response_email(resp).deliver_later
      return redirect_to admin_contact_path(id: params[:id]), notice: "Pomyślnie odpowiedziano"
    end
    redirect_to admin_contacts_path, warning: "Coś poszło nie tak"
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
      :main_page,
      social_satisfaction_levels: [ :threshold, :text ]
    )
  end

  def change_params
    params.require(:change_proposal).permit(:content, :event_id, :title, :description, :positive_description, :negative_description, :budget_name, :budget_change, :is_adding_to_budget, :budget_reserve_change, :need_increase_budget_reserve, :region, :frequency, :negative_title, :positive_title)
  end
end
