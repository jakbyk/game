class AddFieldsToSettings < ActiveRecord::Migration[7.2]
  def change
    add_column :settings, :defeat_description, :text
    add_column :settings, :subjected_description, :text
    add_column :settings, :social_satisfaction_levels, :jsonb, default: []
  end
end
