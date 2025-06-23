class PlaysController < ApplicationController
  before_action :set_play, only: [ :budgets_descriptions, :destroy, :archive, :proceed ]
  before_action :fetch_even_if_finished, only: [ :show ]
  before_action :fetch_finished, only: [ :result ]
  before_action :set_chat, only: [ :show, :budgets_descriptions ]
  before_action :check_allowed, only: [ :create ]
  before_action :check_delete, only: [ :destroy ]
  before_action :check_archive, only: [ :archive ]
  before_action :check_proceed, only: [ :proceed ]

  def show
    redirect_to root_path, alert: "Nie jesteś członkiem tej gry." unless @play && PlayUser.find_by(play: @play, user: current_user)
    redirect_to play_result_path(play_id: @play.id) if @play.is_finished?
  end

  def create
    game = Play.create

    if game.save
      PlayUser.create(play: game, user: current_user, is_leader: true)
      redirect_to play_path(game), notice: "Twoja gra właśnie się zaczęła."
    else
      redirect_to root_path, alert: "Nie udało się utworzyć gry."
    end
  end

  def destroy
    @play.destroy
    redirect_to game_home_path, notice: "Gra została usunięta."
  end

  def budgets_descriptions
    @sample_budget = BudgetCategory.get(name: "Rolnictwo i łowiectwo")
    @budgets = BudgetCategory.all
  end

  def archive
    @play.archive(current_user)
    redirect_to game_home_path, notice: "Gra została zakończona."
  end

  def proceed
    @play.proceed
    redirect_to play_path(@play), notice: "Minął miesiąc, sprawdź co się wydarzyło."
  end

  def result
    redirect_to root_path, alert: "Nie jesteś członkiem tej gry." unless @play && PlayUser.find_by(play: @play, user: current_user)
  end

  private

  def set_play
    play_id = params[:play_id] || params[:id]
    @play = Play.find_by(id: play_id)
  end

  def fetch_even_if_finished
    play_id = params[:play_id] || params[:id]
    play = Play.unscoped.find_by(id: play_id)
    if play.is_active?
      @play = play
    elsif play.is_finished?
      @play = play
    end
  end

  def fetch_finished
    play_id = params[:play_id] || params[:id]
    play = Play.unscoped.find_by(id: play_id)
    if play.is_finished?
      @play = play
    end
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

  def check_proceed
    return if current_user.allowed_to_proceed_game?(@play)

    redirect_to play_path(@play), alert: "Nie jesteś leaderem gry."
  end
end
