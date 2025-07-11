class CreateFriendship < ActiveRecord::Migration[7.2]
  def change
    create_table :friendships, id: :uuid do |t|
      t.references :sender, foreign_key: { to_table: :users }, type: :uuid
      t.references :receiver, foreign_key: { to_table: :users }, type: :uuid
      t.string :status
      t.timestamps
    end
  end
end
