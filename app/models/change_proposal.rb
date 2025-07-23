class ChangeProposal < ApplicationRecord
  before_validation :clear_empty_strings

  belongs_to :user
  belongs_to :event, optional: true

  validates :content, presence: true
  validates :title, :description, presence: true, if: -> { event.present? || is_adding_new_event }
  validates :budget_change, :budget_reserve_change, numericality: { only_integer: true }, allow_nil: true
  validates :is_adding_to_budget, :need_increase_budget_reserve, inclusion: { in: [ true, false, nil ] }
  validates :budget_name, inclusion: { in: BudgetCategory.pluck(:name) }, allow_nil: true
  validates :region, inclusion: { in: Play::REGIONS.values }, allow_nil: true
  validates :frequency, inclusion: { in: 1..100 }, if: -> { event.present? || is_adding_new_event }
  validates :status, inclusion: { in: %w[created implemented not_implemented] }

  validate :validate_budget_section
  validate :validate_reserve_section
  validate :validate_content
  validate :cannot_edit_and_add

  scope :to_check, -> { where(status: "created") }

  def implement
    if event

      shared_attributes = self.attributes.keys & event.attributes.keys
      excluded_keys = [ "id", "created_at", "updated_at", "event_id", "user_id" ]
      attributes_to_copy = shared_attributes - excluded_keys

      attributes_to_copy.each do |attr|
        event[attr] = self[attr]
      end

      event.save!
      update(status: "implemented")
    elsif is_adding_new_event
      shared_attributes = self.attributes.keys & Event.attribute_names
      excluded_keys = [ "id", "created_at", "updated_at", "event_id", "user_id", "is_adding_new_event" ]
      attributes_to_copy = shared_attributes - excluded_keys

      event_attrs = attributes_to_copy.index_with { |attr| self[attr] }

      Event.create!(event_attrs)
      update(status: "implemented")
    end
  end

  def not_implement
    update_column(:status, "not_implemented")
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
    (event.present? || is_adding_new_event) && (
      positive_description.present? ||
        negative_description.present? ||
        (budget_name != nil) ||
        (budget_change != nil && budget_change != 0) ||
        is_adding_to_budget != nil
    )
  end

  def reserve_section_enabled?
    (event.present? || is_adding_new_event) && (
      (budget_reserve_change != 0 && budget_reserve_change != nil) || need_increase_budget_reserve != nil
    )
  end

  def clear_empty_strings
    self.budget_name = nil if wysiwyg_blank?(budget_name)
    self.region = nil if wysiwyg_blank?(region)
  end

  def validate_content
    errors.add(:description, "musi być wypełnione") if wysiwyg_blank?(description) && (event.present? || is_adding_new_event)
    errors.add(:content, "musi być wypełnione") if wysiwyg_blank?(content)
  end

  def wysiwyg_blank?(html)
    ActionView::Base.full_sanitizer.sanitize(html)&.strip.blank?
  end

  def cannot_edit_and_add
    errors.add(:title, "Nie można dodać i edytować wydarzenia jednocześnie") if event.present? && is_adding_new_event
  end
end
