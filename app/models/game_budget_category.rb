class GameBudgetCategory < ApplicationRecord
  belongs_to :play, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :play_id }

  default_scope { order(name: :asc) }
end
