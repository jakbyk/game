class AddStartBudgetToBudgetCategory < ActiveRecord::Migration[7.2]
  def change
    add_column :budget_categories, :start_budget, :bigint, default: 0
  end
end
