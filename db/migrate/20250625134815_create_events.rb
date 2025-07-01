class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :region, default: nil
      t.string :budget_name, default: nil
      t.bigint :budget_change, default: 0
      t.boolean :is_adding_to_budget, default: nil
      t.bigint :budget_reserve_change, default: 0
      t.boolean :need_increase_budget_reserve, default: nil
      t.text :positive_description, default: nil
      t.text :negative_description, default: nil
      t.integer :frequency, default: 50
      t.timestamps
    end
  end
end
