class CreateChats < ActiveRecord::Migration[7.2]
  def change
    create_table :chats do |t|
      t.references :play, null: true, foreign_key: true

      t.timestamps
    end
  end
end
