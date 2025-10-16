class TournamentData < ApplicationRecord
  belongs_to :user
  validates :status, presence: true, inclusion: { in: %w[await_parent await_approve approved] }
end
