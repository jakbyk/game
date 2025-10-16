class CreateTournamentData < ActiveRecord::Migration[7.2]
  def change
    create_table :tournament_data, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :status
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.boolean :over_18
      t.string :parent_first_name
      t.string :parent_last_name
      t.string :school_address
      t.string :school_name
      t.string :parent_email
      t.string :parent_phone_number
      t.string :additional_info
      t.timestamps
    end
  end
end
