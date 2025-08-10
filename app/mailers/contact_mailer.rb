class ContactMailer < ApplicationMailer
  def response_email(contact_message)
    @contact = contact_message
    mail(to: @contact.email_to_respond, subject: "Odpowiedź od twórców gry \"Gra o Polskę\"")
  end
end
