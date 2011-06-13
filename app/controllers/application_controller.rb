# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

#Fixme - please modify the code for indentation and spacing
#If you are using comma, then put a space after it
#If you are using an operator, then put spaces before and after it
#If the code contains nesting, for ex- decision tree or block, indent them properly
#Remove the extra lines from all files
class ApplicationController < ActionController::Base
  filter_parameter_logging "password"
  include HoptoadNotifier::Catcher
  include AuthenticatedSystem
  helper :all 

  protect_from_forgery

  def browse_by_platform
    @games = paginate(Game.browse_by_platform(params[:platform])) 
   rescue
    redirect_with_flash(:notice, "No game found.",games_path)
  end
  
  def browse_by_category
    @games = paginate(Game.browse_by_category(params[:category]))
   rescue
    redirect_with_flash(:notice, "No game found.",games_path)
  end  


  private
  
  def redirect_with_flash(flash_type, flash_msg, page_path)
    flash[flash_type] = flash_msg
    redirect_to page_path
  end
  
  def admin_authenticate
    authenticate_or_request_with_http_basic("Games") do |username, password|
      username == "admin" && password == "secret123"
    end   
  end

  def authorize
    unless logged_in?
      session[:original_uri] = request.request_uri
      #fix-pks make it restful
      redirect_with_flash(:notice, "You must be logged in.", login_path)
    end
  end

  #fix-pks the filter name is confusing, give it appropriate name
  def already_logged_in
      redirect_to games_path if logged_in?
  end

  def last_uri
    session[:uri] = request.request_uri
  end

  def load_game
    @game = Game.find_by_id(params[:id])  
    return_path = params[:controller].include?('admin') ? admin_games_path : games_path
    return redirect_with_flash(:error, "No game found", return_path) unless @game           
  end
  
  def load_user
    @user = User.find_by_id(params[:id])
  end                                           

  def paginate(list)
    list.paginate :page => params[:page], :order => 'name'
  end

end
