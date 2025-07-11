class CreatePlayInvitation < ActiveRecord::Migration[7.2]
  def change
    create_table :play_invitations, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :invitor, foreign_key: { to_table: :users }, null: false, type: :uuid
      t.references :play, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
