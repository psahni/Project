ActionController::Routing::Routes.draw do |map|
  map.resources :users, :member => {:personal_details => :get,
                                    :subs_details => :get,    
                                    :new_password => :get },
                         :collection => {:dashboard => :get}           
  map.resource :session
  map.resources :games, :member => {:shortlist => :get, :grab => :get, 
                                    :grab_page => :get, :remove_shortlisted_game => :get,
                                    :mark_favorite => :post, :remove_favorite_game => :delete},
                                    :collection => {:search => :any, :favorite_games => :get}
  map.favorite_games '/games/favorite_games', :controller => 'games', :action => :favorite_games
  map.browse_by_category '/games/category/:category', :controller => "games", :action => 'browse_by_category'
  map.browse_by_platform '/games/platform/:platform', :controller => "games" , :action => 'browse_by_platform'

  map.browse_by_category 'admin/games/category/:category', :controller => "admin/games", :action => 'browse_by_category'
  map.browse_by_platform 'admin/games/platform/:platform', :controller => "admin/games" , :action => 'browse_by_platform'
  
  map.admin '/admin', :controller => 'admin/games', :action => 'index'

  map.remove '/remove_image', :controller => 'admin/games', :action => 'remove_image'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.change_password '/change_password', :controller => 'users', :action => 'change_password'
  map.confirmation '/confirmation/:id',:controller => 'static',:action => 'confirmation'
  map.contact_us '/contact_us',:controller => 'static',:action => 'contact_us'
  map.about_us '/about_us',:controller => 'static',:action => 'about_us'
  map.root :controller => "games", :action => "index"
  
  map.namespace :admin do |admin|
    admin.resources :games
    admin.resources :users, :member => {:activate_account => :any, :deactivate_account => :get, :renew_subscription => :any, :rent_game => :get, :return_game => :get, :send_mail => :post, :send_mail_form => :get }, 
                            :collection => {:search => :get,
                                            :send_notifications => :get}

  end      

  map.forgot '/forgot', :controller => 'users', :action => 'forgot'
  map.reset 'reset/:reset_code', :controller => "users", :action => 'reset'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
