class UserMailer < ApplicationMailer
  def confirmation_email(user)
    @user = user
    @url  = confirm_users_url(token: user.confirmation_token)
    mail(to: @user.email, subject: "Potwierdź swoje konto")
  end

  def reset_password_email(user)
    @user = user
    @url = edit_password_resets_url(token: user.reset_password_token)
    mail(to: user.email, subject: "Zresetuj swoje hasło")
  end

  def parent_confirmation_email(user)
    @user = user
    @url = tournament_registration_approve_url(id: user.tournament_data.id)
    @regulation_url = pages_regulation_url
    @info_url = pages_information_on_the_processing_of_personal_data_url
    mail(to: user.tournament_data.parent_email, subject: "Zatwierdź udział dziecka w Grze o Polskę")
  end
end
