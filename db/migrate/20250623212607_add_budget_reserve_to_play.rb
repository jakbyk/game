class AddBudgetReserveToPlay < ActiveRecord::Migration[7.2]
  def change
    add_column :plays, :budget_reserve, :bigint
  end
end
