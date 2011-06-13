module GamesHelper

  def button_availability(game)

    path = params[:action]=='index' || params[:action]=='browse_by_platform' || params[:action]=='browse_by_category' ? grab_page_game_path(game) : grab_game_path(game)
    label = params[:action]=='index' || params[:action]=='browse_by_platform' || params[:action]=='browse_by_category' ? "Available to Grab" : "Grab Now!"
    label_class = "grab"
    if logged_in?
      if (current_user.notified_games.include?(game) && !current_user.grabbed_game) || (current_user.can_grab_game?(game) && current_user.shortlisted_games.include?(game))
        link_to label, path, {:class => label_class}
      elsif current_user.shortlisted_games.include?(game)
        "<span class='shortlisted'>&nbsp;</span>"
      elsif current_user.rented_game == game
        "<span id='rented'>&nbsp;</span>"
      elsif current_user.grabbed_game
        current_user.grabbed_game == game ? "<span id='grabbed'>&nbsp;</span>" : (current_user.shortlisted_games.include?(game) ? "<span class='shortlisted'>&nbsp;</span>" : link_to("Shortlist", shortlist_game_path(game), {:class => "action_button shortlist"}))
      else
        game_notified_users(game)
      end
    else
      game_notified_users(game)
    end
  end
  
  def game_notified_users(game)
    path = params[:action]=='index' || params[:action]=='browse_by_platform' || params[:action]=='browse_by_category' ? grab_page_game_path(game) : grab_game_path(game)
    label = params[:action]=='index' || params[:action]=='browse_by_platform' || params[:action]=='browse_by_category' ? "Available to Grab" : "Grab Now!"
    label_class = "grab" 
    if !game.notified_users.blank?
      !(game.available_for_shortlisting && game.notified_users) ? link_to("Shortlist", shortlist_game_path(game), {:class => "shortlist"}) : link_to(label, path, {:class => label_class})
    else
      game.available_for_shortlisting ? link_to("Shortlist", shortlist_game_path(game), {:class => "shortlist"}) : link_to(label, path, {:class => label_class})
    end
  end
  
end