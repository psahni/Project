class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :games, :name
    add_index :games_users, [:game_id, :user_id]
    add_index :users, :name
  end

  def self.down
    remove_index :games, :name
    remove_index :games_users, [:game_id, :user_id]
    remove_index :users, :name
  end
end
