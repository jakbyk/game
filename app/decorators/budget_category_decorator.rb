class BudgetCategoryDecorator < Draper::Decorator
  delegate_all

  include ActionView::Helpers::NumberHelper

  def formatted_start_budget
    number_with_delimiter(object.start_budget * 1_000, delimiter: " ") + " zł"
  end
end
