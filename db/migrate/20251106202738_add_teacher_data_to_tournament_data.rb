class AddTeacherDataToTournamentData < ActiveRecord::Migration[7.2]
  def change
    add_column :tournament_data, :teacher_data, :text
  end
end
