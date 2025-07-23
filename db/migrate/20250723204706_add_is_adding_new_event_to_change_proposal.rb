class AddIsAddingNewEventToChangeProposal < ActiveRecord::Migration[7.2]
  def change
    add_column :change_proposals, :is_adding_new_event, :boolean, default: false
  end
end
