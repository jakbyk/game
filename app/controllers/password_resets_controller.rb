class PasswordResetsController < ApplicationController
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
    @user = User.find_by(reset_password_token: params[:token])

    redirect_to new_password_resets_path, alert: "Link do resetu hasła jest nieprawidłowy lub wygasły." if @user.nil?
    if @user.nil? || !@user.password_reset_token_valid?
      redirect_to new_password_resets_path, alert: "Link do resetu hasła jest nieprawidłowy lub wygasły."
    end
  end

  def update
    @user = User.find_by(reset_password_token: params[:token])

    if @user.nil? || !@user.password_reset_token_valid?
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
end
