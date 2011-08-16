
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

  #alias :admin_logged_in? :admin_authenticate

  helper_method :admin_logged_in?
  
  def redirect_with_flash(flash_type, flash_msg, page_path)
    flash[flash_type] = flash_msg
    redirect_to page_path
  end

  def admin_logged_in?
    session[:admin] == "secret123"
  end

  def admin_authenticate
    authenticate_or_request_with_http_basic("Games") do |username, password|
      session[:admin]  = username == "admin" && password == "secret123" ? password : nil
    end   
  end

  def authorize
    unless logged_in?
      session[:original_uri] = request.request_uri
      redirect_with_flash(:notice, "You must be logged in.", login_path)
    end
  end

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
