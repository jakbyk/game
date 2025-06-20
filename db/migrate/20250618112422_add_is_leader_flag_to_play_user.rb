class AddIsLeaderFlagToPlayUser < ActiveRecord::Migration[7.2]
  def change
    add_column :play_users, :is_leader, :boolean, default: false
  end
end
