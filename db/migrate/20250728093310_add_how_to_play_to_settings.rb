class AddHowToPlayToSettings < ActiveRecord::Migration[7.2]
  def change
    add_column :settings, :how_to_play, :text
    add_column :settings, :contact, :text
  end
end
