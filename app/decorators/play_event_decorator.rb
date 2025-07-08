class PlayEventDecorator < Draper::Decorator
  delegate_all

  def name_of_month
    years = month / 12
    my_month = month % 12
    "#{Play::MONTH_NAMES[my_month]} #{Play::START_YEAR + years}"
  end
end
