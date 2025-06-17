class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      if user.confirmed?
        session[:user_id] = user.id
        redirect_to root_path, notice: "Zalogowano poprawnie."
      else
        flash.now[:alert] = "Proszę potwierdzić adres email przed zalogowaniem."
        render :new
      end
    else
      flash.now[:alert] = "Nieprawidłowy email lub hasło"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Wylogowano."
  end
end
