class AddNameAndTimerToPlay < ActiveRecord::Migration[7.2]
  def change
    add_column :plays, :minutes_for_voting, :integer, default: 0
  end
end
