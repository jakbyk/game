class PlayDecorator < Draper::Decorator
  delegate_all

  include ActionView::Helpers::NumberHelper

  def formatted_budget_reserve
    number_with_delimiter(object.budget_reserve * 1_000, delimiter: " ") + " zł"
  end

  def name_of_result
    return "Aktywna" if result == "active"
    return "Poddana" if result == "subjected"
    return "Przegrana" if result == "defeat"
    "Wygrana" if result == "win"
  end
end
