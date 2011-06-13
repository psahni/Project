class AddCategoriesGame < ActiveRecord::Migration
  def self.up
    create_table :categories_games, :id => false do |t|
	    t.integer :game_id
	    t.integer :category_id
    end
  end

  def self.down
    drop_table :categories_games
  end
end
