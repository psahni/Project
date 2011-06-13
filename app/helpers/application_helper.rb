# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def set_paginate_value(model_name)
    model_name = model_name ? model_name : Game
    params[:page]=1 if !params[:page] 
    @upper_limit = params[:page].to_i*model_name.per_page.to_i rescue 0
    @lower_limit = @upper_limit-model_name.per_page.to_i+1
    @upper_limit = model_name.count if @upper_limit>model_name.count
    if model_name.count.zero? || params[:page].to_i > model_name.count / model_name.per_page.to_i+1
      "<span class='no_value'>No record found</span>"
    else
      "<span>Showing #{@lower_limit}-#{@upper_limit} out of #{model_name.count}</span>"
    end
  end

  def platform_image(game)
    if game.platform_id==1
      "<img src='/images/ps3.png'>"
    elsif game.platform_id==2
      "<img src='/images/xbox.png'>" 
    end
  end 

  def browse_games(params)
    case params
    when 'ps3'
      set_paginate_value(Game.ps3)       
    when 'xbox360'
      set_paginate_value(Game.xbox360)
    when 'action'
      set_paginate_value(Category.find_by_name('Action').games)
    when 'adventure'
      set_paginate_value(Category.find_by_name('Adventure').games)
    when 'simulation'
      set_paginate_value(Category.find_by_name('Simulation').games)
    when 'role_playing'
      set_paginate_value(Category.find_by_name('Role Playing').games)
    when 'strategy'
      set_paginate_value(Category.find_by_name('Strategy').games)
    end
  end
  
    def game_details(game, user)
    @games_user = GamesUser.find_by_game_id(game.id, :conditions => {:user_id => user, :status => RENTING_STATUS[:subscribed]})
  end
  
  def grabbed_game_details(game, user)
    game_details(game, user)
    "Grabbed On: #{@games_user.grabbed_at.strftime('%d-%m-%Y')}<br />" if @games_user.grabbed_at
  end
  
  def rented_game_details(game, user)
    game_details(game, user)
    "Rented On: #{@games_user.rented_at.strftime('%d-%m-%Y')}<br />" if @games_user.rented_at
  end
  
  def returned_game_details(game, user)
    game_details(game, user)
    "Returned On: #{@games_user.returned_at.strftime('%d-%m-%Y')}<br />" if @games_user.returned_at
  end
  
  def active_class(controller, action)
    if params[:controller] == controller && params[:action] == action
      "active"
    end
  end
  
  def platform_browse_class
    if params[:controller] == 'games' && params[:action] == 'browse'
      if params[:cat]=='ps3' || params[:cat]=='xbox360'
        "active"
      end
    end
  end
  
  def category_browse_class
    if params[:controller] == 'games' && params[:action] == 'browse'
      if params[:cat]=='action' || params[:cat]=='adventure' || params[:cat]=='simulation' || params[:cat]=='role playing' || params[:cat]=='strategy'
        "active"
      end
    end
  end

end
