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
  validate :validate_content

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

  def positive_title?
    !wysiwyg_blank?(positive_title)
  end

  def negative_title?
    !wysiwyg_blank?(negative_title)
  end

  private

  def validate_budget_section
    if budget_section_enabled?
      errors.add(:positive_description, "nie może być puste") if wysiwyg_blank?(positive_description)
      errors.add(:negative_description, "nie może być puste") if wysiwyg_blank?(negative_description)
      errors.add(:budget_name, "nie może być puste") if wysiwyg_blank?(budget_name)
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
    self.budget_name = nil if wysiwyg_blank?(budget_name)
    self.region = nil if wysiwyg_blank?(region)
  end

  def wysiwyg_blank?(html)
    ActionView::Base.full_sanitizer.sanitize(html)&.strip.blank?
  end

  def validate_content
    errors.add(:description, "musi być wypełnione") if wysiwyg_blank?(description)
  end
end
