class PlayDecorator < Draper::Decorator
  delegate_all

  include ActionView::Helpers::NumberHelper

  def formatted_budget_reserve
    number_with_delimiter(object.budget_reserve * 1_000, delimiter: " ") + " zł"
  end
end
