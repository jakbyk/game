class CreatePlayInvitation < ActiveRecord::Migration[7.2]
  def change
    create_table :play_invitations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :invitor, foreign_key: { to_table: :users }, null: false
      t.references :play, null: false, foreign_key: true
      t.timestamps
    end
  end
end
