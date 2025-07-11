class CreateGameBudgetCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :game_budget_categories, id: :uuid do |t|
      t.string :name
      t.bigint :current_value
      t.bigint :expected_value
      t.integer :positive_combo, default: 0
      t.integer :negative_combo, default: 0
      t.references :play, null: false, foreign_key: true, type: :uuid
    end
  end
end
