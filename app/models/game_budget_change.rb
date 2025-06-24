class GameBudgetChange < ApplicationRecord
  belongs_to :play
  belongs_to :user

  has_many :game_budget_change_votes

  scope :active, -> { where(is_votable: true) }
  scope :un_active, -> { where(is_votable: false) }

  default_scope { order(created_at: :desc) }

  def votes_favor_count
    game_budget_change_votes.favor.count
  end

  def votes_against_count
    game_budget_change_votes.against.count
  end

  def apply_if_should
    users_count = play.users.count
    half_users_count = users_count / 2
    if votes_favor_count > 0 && votes_favor_count >= half_users_count
      apply_to_game
    elsif votes_against_count > half_users_count
      mark_as_unapproved
    end
  end

  def apply_to_game
    budget = play.game_budget_categories.find_by(name: name).current_value
    reserve = play.budget_reserve
    if is_adding
      new_budget = budget + value
      new_reserve = reserve - value
    else
      new_budget = budget - value
      new_reserve = reserve + value
    end
    if new_reserve > 0
      play.update(budget_reserve: new_reserve)
      play.game_budget_categories.find_by(name: name).update(current_value: new_budget)
      update(is_votable: false)
    end
  end

  def mark_as_unapproved
    update(is_votable: false)
  end

  def was_implement?
    users_count = play.users.count
    half_users_count = users_count / 2
    is_votable == false && votes_favor_count >= half_users_count
  end
end
