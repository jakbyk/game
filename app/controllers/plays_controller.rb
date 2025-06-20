class PlaysController < ApplicationController
  before_action :set_play, only: [:show, :budgets_descriptions]
  before_action :set_chat, only: [:show, :budgets_descriptions]

  def show
    redirect_to root_path, alert: "Nie jesteś członkiem tej gry" unless @play && PlayUser.find_by(play: @play, user: current_user)
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

  def budgets_descriptions
    @sample_budget = BudgetCategory.get(name: 'Rolnictwo i łowiectwo')
    @budgets = BudgetCategory.all
  end

  private

  def set_play
    play_id = params[:play_id] || params[:id]
    @play = Play.find_by(id: play_id)
  end

  def set_chat
    @chat = @play.chat if @play && PlayUser.find_by(play: @play, user: current_user)
  end
end
