class AddSocialSatisfactionToPlay < ActiveRecord::Migration[7.2]
  def change
    add_column :plays, :social_satisfaction, :float, default: 60.0
  end
end
