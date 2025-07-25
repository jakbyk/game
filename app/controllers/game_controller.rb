class GameController < ApplicationController
  def home
    redirect_to login_path, warning: "Musisz być zalogowany, aby zagrać", status: :see_other unless logged_in?
    @plays = current_user&.plays&.active
    @invitations = current_user&.play_invitations
  end
end
