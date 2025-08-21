class GameBudgetCategory < ApplicationRecord
  belongs_to :play

  validates :name, presence: true, uniqueness: { scope: :play_id }
  validates :current_value, numericality: { greater_than_or_equal_to: 0 }

  default_scope { order(name: :asc) }
end
