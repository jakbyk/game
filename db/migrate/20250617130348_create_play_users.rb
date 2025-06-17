class CreatePlayUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :play_users do |t|
      t.references :play, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
