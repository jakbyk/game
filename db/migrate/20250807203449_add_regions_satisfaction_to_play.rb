class AddRegionsSatisfactionToPlay < ActiveRecord::Migration[7.2]
  def change
    add_column :plays, :regions_satisfaction, :jsonb, default: Play::REGIONS.keys.map { |key| [ key.to_s, 11 ] }.to_h.to_json
  end
end
