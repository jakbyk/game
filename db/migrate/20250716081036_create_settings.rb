class CreateSettings < ActiveRecord::Migration[7.2]
  def change
    create_table :settings, id: :uuid do |t|
      t.text :information_on_the_processing_of_personal_data
      t.text :regulations
      t.timestamps
    end
  end
end
