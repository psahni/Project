module Admin::UsersHelper

  def link_rent(user)
    if user.grabbed_game
      link_to "RENT", rent_game_admin_user_path(user)
    end
  end
  
  def link_return(user)
    if user.rented_game
      link_to "RETURN", return_game_admin_user_path(user)
    end
  end
  
  def grabbed_on_time(game, user)
    game.games_users.collect do |x|
      x.grabbed_at.strftime("%d-%m-%Y") if x.status==RENTING_STATUS[:grabbed] && x.grabbed_at && x.user_id==user.id
    end
  end
  
  def rented_on_time(game, user)
    game.games_users.collect do |x|
      x.rented_at.strftime("%d-%m-%Y") if x.status==RENTING_STATUS[:rented] && x.rented_at && x.user_id==user.id
    end
  end

end