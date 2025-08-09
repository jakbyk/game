class AddNegativeAndPositiveTitleToEvent < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :negative_title, :string, default: nil
    add_column :events, :positive_title, :string, default: nil
  end
end
