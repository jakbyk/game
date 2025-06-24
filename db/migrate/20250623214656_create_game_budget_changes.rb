class CreateGameBudgetChanges < ActiveRecord::Migration[7.2]
  def change
    create_table :game_budget_changes do |t|
      t.string :name
      t.bigint :value
      t.boolean :is_adding
      t.references :play, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
