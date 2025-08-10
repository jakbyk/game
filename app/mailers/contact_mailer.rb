class ContactMailer < ApplicationMailer
  def response_email(response)
    @contact = response.contact_message
    @message = response.message
    mail(to: @contact.email_to_respond, subject: "Odpowiedź od twórców gry \"Gra o Polskę\"")
  end
end
