class AddUniqueIndexes < ActiveRecord::Migration[7.2]
  def change
    add_index :game_budget_change_votes, [ :user_id, :game_budget_change_id ], unique: true, name: "index_votes_on_user_and_change"
    add_index :game_budget_categories, [ :play_id, :name ], unique: true
    add_index :chats, :play_id, unique: true, where: "play_id IS NULL", name: "index_chats_on_play_id_null_unique"
  end
end
