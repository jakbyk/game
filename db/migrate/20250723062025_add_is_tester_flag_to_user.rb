class AddIsTesterFlagToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :is_tester, :boolean, default: false
  end
end
