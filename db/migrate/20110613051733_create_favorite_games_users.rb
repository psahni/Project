class CreateFavoriteGamesUsers < ActiveRecord::Migration
  def self.up
    create_table :favorite_games_users do |t|
      t.integer :user_id
      t.integer :favorite_game_id

      t.timestamps
    end
  end

  def self.down
    drop_table :favorite_games_users
  end
end
