class AddCurrentMonthToPlay < ActiveRecord::Migration[7.2]
  def change
    add_column :plays, :current_month, :integer, default: 0
  end
end
