class AddagecategoryIdToGame < ActiveRecord::Migration
  def self.up
    add_column :games,:age_category_id,:integer
  end

  def self.down
    remove_column :games,:age_category,:integer
  end
end
