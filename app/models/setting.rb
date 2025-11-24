class Setting < ApplicationRecord
  validate :only_one_can_exist, on: :create
  validate :there_could_be_only_one, on: :update

  def social_satisfaction_levels
    raw = super
    if raw.is_a?(Array)
      raw
    elsif raw.is_a?(Hash)
      raw.values
    else
      []
    end
  end

  def is_tournament_time?
    tournament_start_time < local_time && local_time < tournament_end_time
  end

  def tournament_has_started?
    tournament_start_time < local_time
  end

  def tournament_start_time
    tournament_start.in_time_zone("Europe/Warsaw").change(hour: 12, min: 0, sec: 0)
  end

  def tournament_end_time
    tournament_end.in_time_zone("Europe/Warsaw").change(hour: 20, min: 0, sec: 0)
  end

  def local_time
    DateTime.now.in_time_zone("Europe/Warsaw")
  end

  private

  def only_one_can_exist
    return if Setting.count == 0

    errors.add(:base, "There is already one setting")
  end

  def there_could_be_only_one
    return if Setting.count == 1

    errors.add(:base, "There is already one setting")
  end
end
