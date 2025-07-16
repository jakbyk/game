class AddFieldsToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :time_of_acceptance_of_information_on_the_processing_of_personal, :timestamp
    add_column :users, :time_of_acceptance_of_the_regulations, :timestamp
  end
end
