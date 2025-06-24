class GameBudgetCategoryDecorator < Draper::Decorator
  delegate_all

  include ActionView::Helpers::NumberHelper

  def formatted_current_budget
    number_with_delimiter(object.current_value * 1_000, delimiter: " ") + " zł"
  end
end
