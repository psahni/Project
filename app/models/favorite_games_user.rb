class FavoriteGamesUser < ActiveRecord::Base
  belongs_to :game, :foreign_key => :favorite_game_id
  belongs_to :user
end
