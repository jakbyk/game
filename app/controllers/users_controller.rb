class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [ :add_tester, :remove_tester, :add_admin, :remove_admin, :abusive ]
  before_action :set_user, only: [ :add_tester, :remove_tester, :add_admin, :remove_admin, :abusive ]
  before_action :authenticate_super_admin!, only: [ :add_admin, :remove_admin ]
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

  def add_tester
    @user.update(is_tester: true)
    redirect_to admin_user_path(@user), notice: "Dodano status testera"
  end

  def remove_tester
    @user.update(is_tester: false)
    redirect_to admin_user_path(@user), notice: "Usunięto status testera"
  end

  def add_admin
    @user.update(is_admin: true)
    redirect_to admin_user_path(@user), notice: "Dodano status testera"
  end

  def remove_admin
    @user.update(is_admin: false)
    redirect_to admin_user_path(@user), notice: "Usunięto status testera"
  end

  def abusive
    if @user.update(name: @user.id.to_s)
      redirect_to admin_user_path(@user), notice: "Nazwa użytkownika została zaktualizowana"
    else
      new_name = @user.id.to_s + ("a".."z").sort_by { rand }[0, 8].join
      @user.update(name: new_name)
      redirect_to admin_user_path(@user), notice: "Nazwa użytkownika została zaktualizowana"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :first_name, :last_name, :password_confirmation, :accept_data_processing, :accept_regulations)
  end

  def set_user
    @user = User.find(params[:id])
    redirect_to root_path, alert: "Nie znaleziono takiego użytkownika" unless @user
  end

  def authenticate_super_admin!
    return if logged_in? && current_user.is_super_admin?

    redirect_to root_path, alert: "Nie masz dostępu do tej funkcji."
  end
end
