class AddTournamentTimestamps < ActiveRecord::Migration[7.2]
  def change
    add_column :settings, :tournament_start, :timestamp
    add_column :settings, :tournament_end, :timestamp
  end
end
