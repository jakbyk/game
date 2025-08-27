class AddReasonNotImplementColumnToGameBudgetChange < ActiveRecord::Migration[7.2]
  def change
    add_column :game_budget_changes, :reason_not_implemented, :string, null: true, default: nil
  end
end
