class CreatePlayEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :play_events do |t|
      t.references :play, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer :month, null: false

      t.string :outcome
      t.datetime :resolved_at

      t.timestamps
    end
  end
end
