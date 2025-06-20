class PlaysController < ApplicationController
  before_action :set_play, only: [:show]

  def show
    redirect_to root_path, alert: "Nie jesteś członkiem tej gry" unless @play && PlayUser.find_by(play: @play, user: current_user)

    @chat = @play.chat
  end

  def create
    game = Play.create

    if game.save
      PlayUser.create(play: game, user: current_user, is_leader: true)
      redirect_to play_path(game), notice: "Twoja gra właśnie się zaczęła"
    else
      redirect_to root_path, alert: "Nie udało się utworzyć gry"
    end
  end

  private

  def set_play
    @play = Play.find(params[:id])
  end
end
