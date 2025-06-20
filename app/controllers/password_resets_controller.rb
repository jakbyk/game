class PasswordResetsController < ApplicationController
  before_action :load_user, only: [:edit, :update]
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user
      user.generate_password_reset_token!
      UserMailer.reset_password_email(user).deliver_later
    end

    redirect_to login_path, notice: "Jeśli twój email istnieje w bazie to otrzymasz niebawem maila z linkiem do resetu hasła."
  end

  def edit
    if !@user.password_reset_token_valid?
      redirect_to new_password_resets_path, alert: "Link do resetu hasła jest nieprawidłowy lub wygasły."
    end
  end

  def update
    if !@user.password_reset_token_valid?
      redirect_to new_password_resets_path, alert: "Link wygasł, spróbuj ponownie."
    elsif @user.update(password_params)
      @user.clear_password_reset_token!
      redirect_to login_path, notice: "Twoje hasło zostało zmienione, możesz się teraz zalogować."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def load_user
    @user = params[:token] ? User.find_by(reset_password_token: params[:token]) : nil

    redirect_to root_path, alert: "Link do resetu hasła jest nieprawidłowy lub wygasły." if @user.nil?
  end
end
