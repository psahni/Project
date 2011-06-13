class AddcategoryIdToGame < ActiveRecord::Migration
  def self.up
    add_column :games,:category_id,:integer
  end

  def self.down
    remove_column :games,:category_id
  end
end
