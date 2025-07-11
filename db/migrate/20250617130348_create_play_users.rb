class CreatePlayUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :play_users, id: :uuid do |t|
      t.references :play, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
