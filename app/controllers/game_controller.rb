class GameController < ApplicationController
  def home
    redirect_to login_path, warning: "Musisz być zalogowany, aby zagrać", status: :see_other unless logged_in?
    @plays = current_user.plays
  end
end
