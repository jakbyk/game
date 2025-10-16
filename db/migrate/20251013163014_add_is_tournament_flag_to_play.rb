class AddIsTournamentFlagToPlay < ActiveRecord::Migration[7.2]
  def change
    add_column :plays, :is_tournament, :boolean, default: false
  end
end
