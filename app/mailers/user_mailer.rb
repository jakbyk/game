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
end
