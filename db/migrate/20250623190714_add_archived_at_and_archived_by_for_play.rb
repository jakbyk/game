class AddArchivedAtAndArchivedByForPlay < ActiveRecord::Migration[7.2]
  def change
    add_column :plays, :archived_at, :datetime

    add_reference :plays, :archived_by, foreign_key: { to_table: :users }, type: :uuid
  end
end
