class CreateContactMessagesTable < ActiveRecord::Migration[7.2]
  def change
    create_table :contact_messages, id: :uuid do |t|
      t.string :email_to_respond
      t.text :message
      t.boolean :is_read, default: false
      t.references :user, null: true, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
