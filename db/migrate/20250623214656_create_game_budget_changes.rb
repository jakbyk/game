class CreateGameBudgetChanges < ActiveRecord::Migration[7.2]
  def change
    create_table :game_budget_changes, id: :uuid do |t|
      t.string :name
      t.bigint :value
      t.boolean :is_adding
      t.references :play, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
