class AddNegativeAndPositiveTitleToChangeProposal < ActiveRecord::Migration[7.2]
  def change
    add_column :change_proposals, :negative_title, :string, default: nil
    add_column :change_proposals, :positive_title, :string, default: nil
  end
end
