class PlayEvent < ApplicationRecord
  belongs_to :play
  belongs_to :event

  enum outcome: {
    positive: "positive",
    negative: "negative",
    neutral: "neutral"
  }, _suffix: true

  validates :month, presence: true
  validates :outcome, inclusion: { in: outcomes.keys }, allow_nil: true

  after_create :change_value_in_play

  default_scope { order(month: :desc) }

  private

  def change_value_in_play
    unless event.need_increase_budget_reserve.nil?
      if event.need_increase_budget_reserve == true
        new_budget_reserve = play.budget_reserve + event.budget_reserve_change
      else
        new_budget_reserve = play.budget_reserve - event.budget_reserve_change
      end
      play.update(budget_reserve: new_budget_reserve)
    end
    unless event.is_adding_to_budget.nil?
      if event.is_adding_to_budget == true
        new_budget = play.game_budget_categories.find_by(name: event.budget_name).expected_value + event.budget_change
      else
        new_budget = play.game_budget_categories.find_by(name: event.budget_name).expected_value - event.budget_change
      end
      play.game_budget_categories.find_by(name: event.budget_name).update(expected_value: new_budget)
    end
  end
end
