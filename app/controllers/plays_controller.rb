class PlaysController < ApplicationController
  before_action :set_play, only: [ :budgets_descriptions, :destroy, :archive, :proceed, :expenses, :create_budget_change, :budget_changes, :budget_vote, :players, :invite_player, :accept_invitation, :online_users ]
  before_action :fetch_even_if_finished, only: [ :show ]
  before_action :fetch_finished, only: [ :result ]
  before_action :set_chat, only: [ :show, :budgets_descriptions, :budget_changes, :expenses, :players ]
  before_action :check_allowed, only: [ :create ]
  before_action :check_delete, only: [ :destroy ]
  before_action :check_archive, only: [ :archive ]
  before_action :check_proceed, only: [ :proceed ]
  before_action :check_create_budget_change, only: [ :create_budget_change ]
  before_action :check_invite, only: [ :invite_player ]
  before_action :player_exists, only: [ :budgets_descriptions, :destroy, :archive, :proceed, :expenses, :create_budget_change, :budget_changes, :budget_vote, :players, :result, :show ]
  before_action :check_budget_vote, only: [ :budget_vote ]

  def show
    redirect_to play_result_path(play_id: @play.id) if @play.is_finished?

    @region_name = params[:map_id] ? Play::REGIONS[params[:map_id].to_sym] : nil

    @play_events = @region_name ? @play.play_events.joins(:event).where(events: { region: @region_name }).limit(10) : @play.play_events.limit(10)
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
  end

  def expenses
    @budgets = @play.game_budget_categories
  end

  def create_budget_change
    gbc = GameBudgetChange.new(play: @play, user: current_user, is_adding: params[:is_adding] == "true", value: params[:value], name: params[:name])
    if gbc.save
      redirect_to play_budget_changes_path(@play), notice: "Zagłosuj za swoją zmianą."
    else
      redirect_to play_expenses_path(@play), alert: "Nie udało się stworzyć propozycji zmiany budżetu."
    end
  end

  def budget_changes
    @active_budget_changes = @play.game_budget_changes.active
    @un_active_budget_changes = @play.game_budget_changes.un_active
  end

  def budget_vote
    game_budget_change = @play.game_budget_changes.find_by(id: params[:game_budget_change_id])
    vote = game_budget_change.game_budget_change_votes.find_or_initialize_by(user: current_user)
    vote.vote = params[:vote]
    if vote.save
      redirect_to play_budget_changes_path(@play), notice: "Oddano głos"
    else
      redirect_to play_budget_changes_path(@play), alert: "Coś poszło nie tak, spróbuj jeszcze raz"
    end
  end

  def players
    @players = @play.users
    @invitations = @play.play_invitations
    @already_invited = @play.play_invitations.map(&:user)
    @friends = current_user.friend_users
    could_invite = ((@friends - @players) - @already_invited).pluck(:name, :id)
    label = could_invite.any? ? "Można wybrać" : "Brak znajomych, których można zaprosić"
    @friends_table = could_invite << [ label, 0 ]
  end

  def invite_player
    @to_invite = nil
    @to_invite = User.find_by(id: params[:id]) if params[:id].present? && params[:id] != "0"
    @to_invite = User.find_by(name: params[:name]) if params[:name].present?
    @to_invite = User.find_by(email: params[:email]) if params[:email].present?
    if @to_invite
      return redirect_to play_players_path(@play), warning: "Ten gracz już jest uczestnikiem gry" if PlayUser.find_by(play: @play, user: @to_invite)
      pi = @play.play_invitations.create(user: @to_invite, invitor: current_user)
      if pi.save
        redirect_to play_players_path(@play), notice: "Użytkownik został zaproszony"
      else
        return redirect_to play_players_path(@play), warning: "Ten gracz jest już zaproszony" if @play.play_invitations.find_by(user: @to_invite)
        redirect_to play_players_path(@play), alert: "Nie udało się zaprosić użytkownika"
      end
    else
      redirect_to play_players_path(@play), alert: "Nie znaleziono użytkownika"
    end
  end

  def accept_invitation
    pi = PlayInvitation.find_by(user: current_user, play: @play)
    if pi
      if pi.accept(current_user, @play)
        redirect_to play_path(@play), notice: "Witaj w grze"
      else
        redirect_to game_home_path, alert: "Nie udało się dołączyć do gry"
      end
    else
      redirect_to game_home_path, alert: "Nie znaleziono takiego zaproszenia"
    end
  end

  def online_users
    render inline: <<~HTML
    <turbo-frame id="game_online_users">
      #{render_to_string(partial: "plays/online_users")}
    </turbo-frame>
  HTML
  end

  private

  def set_play
    play_id = params[:play_id] || params[:id]
    @play = Play.find_by(id: play_id)
  end

  def fetch_even_if_finished
    play_id = params[:play_id] || params[:id]
    play = Play.unscoped.find_by(id: play_id)
    if play&.is_active?
      @play = play
    elsif play&.is_finished?
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

  def check_create_budget_change
    play_member = @play && PlayUser.find_by(play: @play, user: current_user)
    is_adding_correct = params[:is_adding] == "true" || params[:is_adding] == "false"
    value_correct = params[:value].to_i != 0
    name_correct = BudgetCategory.get(name: params[:name]).present?
    return if play_member && is_adding_correct && value_correct && name_correct

    redirect_to play_path(@play), alert: "Nie udało się dodać propozycji zmiany budżetu."
  end

  def player_exists
    return if @play && PlayUser.find_by(play: @play, user: current_user)

    redirect_to game_home_path, alert: "Nie jesteś członkiem tej gry."
  end

  def check_budget_vote
    play_member = @play && PlayUser.find_by(play: @play, user: current_user)
    is_vote_correct = params[:vote] == "true" || params[:vote] == "false"
    game_budget_change_exist = @play.game_budget_changes.find_by(id: params[:game_budget_change_id]).present?
    return if play_member && is_vote_correct && game_budget_change_exist

    redirect_to play_path(@play), alert: "Nie udało się zagłosować w propozycji zmiany budżetu."
  end

  def check_invite
    return if current_user.allowed_to_invite_to_game?(@play)

    redirect_to play_path(@play), alert: "Nie możesz zapraszać do gry."
  end
end
