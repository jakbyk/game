class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user
      user.generate_password_reset_token!
      UserMailer.reset_password_email(user).deliver_later
    end

    redirect_to login_path, notice: "If your email exists in our system, you’ll receive a password reset link shortly."
  end

  def edit
    @user = User.find_by(reset_password_token: params[:token])

    if @user.nil? || !@user.password_reset_token_valid?
      redirect_to new_password_resets_path, alert: "Password reset link is invalid or expired."
    end
  end

  def update
    @user = User.find_by(reset_password_token: params[:token])

    if @user.nil? || !@user.password_reset_token_valid?
      redirect_to new_password_resets_path, alert: "Link expired or invalid."
    elsif @user.update(password_params)
      @user.clear_password_reset_token!
      redirect_to login_path, notice: "Your password has been changed. You can now log in."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
