class CreateGameBudgetChangeVotes < ActiveRecord::Migration[7.2]
  def change
    create_table :game_budget_change_votes, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :game_budget_change, null: false, foreign_key: true, type: :uuid
      t.boolean :vote, default: false

      t.timestamps
    end
  end
end
