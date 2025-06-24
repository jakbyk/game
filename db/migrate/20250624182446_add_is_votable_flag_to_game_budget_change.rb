class AddIsVotableFlagToGameBudgetChange < ActiveRecord::Migration[7.2]
  def change
    add_column :game_budget_changes, :is_votable, :boolean, default: true
  end
end
