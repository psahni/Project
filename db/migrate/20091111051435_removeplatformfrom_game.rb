class RemoveplatformfromGame < ActiveRecord::Migration
  def self.up
    remove_column :games,:platform
    remove_column :games,:age_category
    remove_column :games,:category
  end

  def self.down
    add_column :games,:platform,:string
    add_column :games,:age_category,:string
    add_column :games,:category,:string
  end
end
