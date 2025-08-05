class AddMainPageFieldToSetting < ActiveRecord::Migration[7.2]
  def change
    add_column :settings, :main_page, :text
  end
end
