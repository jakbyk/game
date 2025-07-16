class Setting < ApplicationRecord
  validate :only_one_can_exist, on: :create
  validate :there_could_be_only_one, on: :update

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
