class Event < ApplicationRecord
  before_validation :clear_empty_strings

  validates :title, :description, presence: true
  validates :budget_change, :budget_reserve_change, numericality: { only_integer: true }, allow_nil: true
  validates :is_adding_to_budget, :need_increase_budget_reserve, inclusion: { in: [ true, false, nil ] }
  validates :budget_name, inclusion: { in: BudgetCategory.pluck(:name) }, allow_nil: true
  validates :region, inclusion: { in: Play::REGIONS.values }, allow_nil: true
  validates :frequency, inclusion: { in: 1..100 }

  validate :validate_budget_section
  validate :validate_reserve_section

  has_many :play_events, dependent: :destroy

  def self.take_random
    total = Event.sum(:frequency)
    return nil if total == 0

    threshold = rand(1..total)
    cumulative = 0

    Event.find_each do |event|
      cumulative += event.frequency
      return event if cumulative >= threshold
    end
  end

  private

  def validate_budget_section
    if budget_section_enabled?
      errors.add(:positive_description, "nie może być puste") if positive_description.blank?
      errors.add(:negative_description, "nie może być puste") if negative_description.blank?
      errors.add(:budget_change, "musi być liczbą niezerową") if budget_change.nil? || budget_change == 0
      errors.add(:is_adding_to_budget, "musi być zaznaczone") if is_adding_to_budget.nil?
    end
  end

  def validate_reserve_section
    if reserve_section_enabled?
      errors.add(:budget_reserve_change, "musi być liczbą niezerową") if budget_reserve_change.nil? || budget_reserve_change == 0
      errors.add(:need_increase_budget_reserve, "musi być zaznaczone") if need_increase_budget_reserve.nil?
    end
  end

  def budget_section_enabled?
    positive_description.present? ||
      negative_description.present? ||
      (budget_name != nil) ||
      (budget_change != nil && budget_change != 0) ||
      is_adding_to_budget != nil
  end

  def reserve_section_enabled?
    (budget_reserve_change != 0 && budget_reserve_change != nil) || need_increase_budget_reserve != nil
  end

  def clear_empty_strings
    self.budget_name = nil if budget_name.blank?
    self.region = nil if region.blank?
  end
end
