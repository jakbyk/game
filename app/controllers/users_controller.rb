class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if params[:accept_data_processing] == "1"
      @user.time_of_acceptance_of_information_on_the_processing_of_personal = Time.current
    end

    if params[:accept_regulations] == "1"
      @user.time_of_acceptance_of_the_regulations = Time.current
    end

    if @user.save
      UserMailer.confirmation_email(@user).deliver_later
      redirect_to root_path, notice: "Sprawdź skrzynkę mailową, aby potwierdzić swoje konto."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirm
    user = User.find_by(confirmation_token: params[:token])

    if user.present?
      user.confirm!
      redirect_to login_path, notice: "Twoje konto zostało potwierdzone, możesz się teraz zalogować."
    else
      redirect_to root_path, alert: "Nieprawidłowy lub wygasły token potwierdzający."
    end
  end

  def online
    render inline: <<~HTML
    <turbo-frame id="online_users">
      #{render_to_string(partial: "users/online_users")}
    </turbo-frame>
  HTML
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :first_name, :last_name, :password_confirmation, :accept_data_processing, :accept_regulations)
  end
end
