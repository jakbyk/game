class ProfilesController < ApplicationController
  before_action :require_login

  def show
    @user = User.find_by(id: params[:id])
    return redirect_to root_path, alert: "Nie znaleziono takiego użytkownika" unless @user
    @is_my_profile = @user == current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to profile_path(@user), notice: "Avatar zaktualizowany."
    else
      redirect_to profile_path(@user), alert: "Avatar nie został zaktualizowany."
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end
end
