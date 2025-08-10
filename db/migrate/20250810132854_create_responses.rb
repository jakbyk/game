class CreateResponses < ActiveRecord::Migration[7.2]
  def change
    create_table :responses, id: :uuid do |t|
      t.references :contact_message, null: false, foreign_key: true, type: :uuid
      t.references :user, null: true, foreign_key: true, type: :uuid
      t.text :message, null: false

      t.timestamps
    end
  end
end
