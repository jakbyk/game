class GameBudgetChangeVote < ApplicationRecord
  belongs_to :game_budget_change
  belongs_to :user

  validates :user_id, uniqueness: { scope: :game_budget_change_id, message: "może zagłosować tylko raz na zmianę budżetu" }

  scope :favor, -> { where(vote: true) }
  scope :against, -> { where(vote: false) }

  after_save :check_for_applying

  private

  def check_for_applying
    game_budget_change.apply_if_should
  end
end
