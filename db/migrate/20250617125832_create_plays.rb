class CreatePlays < ActiveRecord::Migration[7.2]
  def change
    create_table :plays do |t|
      t.string :name

      t.timestamps
    end
  end
end
