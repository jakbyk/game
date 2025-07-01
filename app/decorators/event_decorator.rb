class EventDecorator < Draper::Decorator
  delegate_all

  include ActionView::Helpers::NumberHelper

  def formatted_budget_reserve_change
    number_with_delimiter(object.budget_reserve_change * 1_000, delimiter: " ") + " zł"
  end

  def formatted_budget_change
    number_with_delimiter(object.budget_change * 1_000, delimiter: " ") + " zł"
  end
end
