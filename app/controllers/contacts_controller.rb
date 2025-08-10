class ContactsController < ApplicationController
  def create_contact
    cm = ContactMessage.new(contact_message_params)
    cm.user = current_user if current_user.present?
    if cm.save
      redirect_to pages_contact_path, notice: "Wiadomość trafi do twórców gry."
    else
      flash[:cm] = cm
      redirect_to pages_contact_path, alert: "Nie udało się wysłać wiadomości."
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:email_to_respond, :message)
  end
end
