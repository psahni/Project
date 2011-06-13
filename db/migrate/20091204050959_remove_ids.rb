class RemoveIds < ActiveRecord::Migration
  def self.up
    remove_column :categories, :game_id
    remove_column :games, :category_id
  end

  def self.down
    add_column :categories, :game_id, :integer
    add_column :games, :category_id, :integer
  end
end
