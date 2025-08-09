class AddExpectedSatisfactionChangesToPlayEvent < ActiveRecord::Migration[7.2]
  def change
    add_column :play_events, :potential_increase_of_satisfaction, :float, default: 0.0
    add_column :play_events, :potential_decrease_of_satisfaction, :float, default: 0.0
  end
end
