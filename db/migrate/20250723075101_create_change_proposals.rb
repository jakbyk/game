class CreateChangeProposals < ActiveRecord::Migration[7.2]
  def change
    create_table :change_proposals, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :event, null: true, type: :uuid
      t.text :content
      t.string :status, null: false, default: "created"
      t.string :title, default: nil
      t.text :description, default: nil
      t.string :region, default: nil
      t.string :budget_name, default: nil
      t.bigint :budget_change, default: 0
      t.boolean :is_adding_to_budget, default: nil
      t.bigint :budget_reserve_change, default: 0
      t.boolean :need_increase_budget_reserve, default: nil
      t.text :positive_description, default: nil
      t.text :negative_description, default: nil
      t.integer :frequency, default: 1
      t.timestamps
    end
  end
end
