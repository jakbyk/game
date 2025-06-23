class PlaysController < ApplicationController
  before_action :set_play, only: [ :show, :budgets_descriptions, :destroy, :archive ]
  before_action :set_chat, only: [ :show, :budgets_descriptions ]
  before_action :check_allowed, only: [ :create ]
  before_action :check_delete, only: [ :destroy ]
  before_action :check_archive, only: [ :archive ]

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

  def destroy
    @play.destroy
    redirect_to game_home_path, notice: "Gra została usunięta"
  end

  def budgets_descriptions
    @sample_budget = BudgetCategory.get(name: "Rolnictwo i łowiectwo")
    @budgets = BudgetCategory.all
  end

  def archive
    @play.archive(current_user)
    redirect_to game_home_path, notice: "Gra została zakończona"
  end

  private

  def set_play
    play_id = params[:play_id] || params[:id]
    @play = Play.find_by(id: play_id)
  end

  def set_chat
    @chat = @play.chat if @play && PlayUser.find_by(play: @play, user: current_user)
  end

  def check_allowed
    return if current_user.allowed_to_create_new_game?

    redirect_to game_home_path, alert: "Możesz uczestniczyć maksymalnie w trzech grach naraz."
  end

  def check_delete
    return if current_user.allowed_to_delete_game?(@play)

    redirect_to play_path(@play), alert: "Nie jesteś administratorem, nie możesz usunąć tej gry - spróbuj zarchiwizować."
  end

  def check_archive
    return if current_user.allowed_to_archive_game?(@play)

    redirect_to play_path(@play), alert: "Nie jesteś leaderem gry, nie możesz jej zarchiwizować."
  end
end
