class GameBudgetChangeVote < ApplicationRecord
  belongs_to :game_budget_change
  belongs_to :user

  validates :user_id, uniqueness: { scope: :game_budget_change_id, message: "może zagłosować tylko raz na zmianę budżetu" }

  scope :favor, -> { where(vote: true) }
  scope :against, -> { where(vote: false) }

  after_save :check_for_applying
  after_save :check_for_expired_changes

  private

  def check_for_applying
    game_budget_change.apply_if_should
  end

  def check_for_expired_changes
    Play.active.where.not(minutes_for_voting: 0).each do |game|
      voting_limit = game.minutes_for_voting

      expired_changes = GameBudgetChange.where(is_votable: true, play: game)
                                        .where("created_at <= ?", Time.current - voting_limit.minutes)

      expired_changes.find_each do |change|
        change.apply_to_game
      end
    end
  end
end
