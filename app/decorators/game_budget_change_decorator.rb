class GameBudgetChangeDecorator < Draper::Decorator
  delegate_all

  include ActionView::Helpers::NumberHelper

  def formatted_value
    number_with_delimiter(object.value * 1_000, delimiter: " ") + " zł"
  end
end
