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

  def region_id
    Play::REGIONS.invert[event.region]
  end

  def self.name_of_potential(int)
    case int
    when 0..10
      "Marginalne"
    when 11..50
      "Niewielkie"
    when 51..180
      "Niskie"
    when 181..500
      "Umiarkowane"
    when 501..1_500
      "Średnie"
    when 1_501..5_000
      "Znaczące"
    when 5_001..20_000
      "Wysokie"
    when 20_001..100_000
      "Podwyższone"
    when 100_001..500_000
      "Krytyczne"
    else
      "Ekstremalne"
    end
  end

  def is_positive_to_player?
    Event.positive.include?(event)
  end

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
