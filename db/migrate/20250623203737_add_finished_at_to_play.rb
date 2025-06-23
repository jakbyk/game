class AddFinishedAtToPlay < ActiveRecord::Migration[7.2]
  def change
    add_column :plays, :finished_at, :datetime
  end
end
