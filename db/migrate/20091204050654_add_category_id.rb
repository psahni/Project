class AddCategoryId < ActiveRecord::Migration
  def self.up
    add_column :categories, :game_id, :integer
  end

  def self.down
    remove_column :categories, :game_id
  end
end
