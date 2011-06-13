class GamesController < ApplicationController

  before_filter :load_game, :except => [:index, :search, :browse_by_platform, :browse_by_category, :remove_shortlisted_game]
  before_filter :authorize, :only => [:shortlist, :grab, :grab_page, :remove_shortlisted_game]
  before_filter :check_shortlist_status, :only => :shortlist
  before_filter :last_uri, :only => :search

  def index
    @games = Game.paginate :page => params[:page], :order => 'name'
  end

  def search		
    @games = begin
      Game.show_all_games unless params[:search]
      Game.search params[:search], :include => [:age_category, :platform, :categories],
      :field_weights => { :name => 20, :description => 10},
      :order => :name,
      :page => params[:page],
      :per_page => 10
    end
    flash.now[:notice] = "No record found." if @games.blank?
  end

  def show
  end

  #fix-richa use return with multiple redirection to avoid ambiguity. Also what is significance of grab_page name
  def grab_page
    if current_user.grabbed_game
      flash[:notice] = "You have already grabbed #{current_user.grabbed_game.name}."
    elsif current_user.rented_game
      flash[:notice] = "To get this game, you must return #{current_user.rented_game.name} which has been issued to you."
    end
    redirect_to game_path(@game)
  end

  def grab
    if current_user.can_grab_game?(@game)
      if current_user.notified_games.include?(@game) || current_user.shortlisted_games.include?(@game) 
        #fix-richa instead of having iterator for all games, you can find out that game and update the attributes if it exists
        game = GamesUser.find(:first, :conditions => ["(status = ? OR status = ?) AND user_id = ? AND game_id = ?", RENTING_STATUS[:shortlisted], RENTING_STATUS[:notified], current_user.id, @game.id])
        game.update_attributes(:status => RENTING_STATUS[:grabbed], :grabbed_at => Time.now)
      else
        current_user.games_users.create(:game => @game, :status => RENTING_STATUS[:grabbed], :grabbed_at => Time.now)
      end
      #fix-richa you dont need to assign flash[:notice] individually for each condition.
      !current_user.rented_game.blank? ? flash[:notice] = "#{@game.name} has been grabbed by you. Please bring the game #{current_user.rented_game.name} with you which was issued to you earlier. An email has been sent to you for further information." : flash[:notice] = "#{@game.name} has been grabbed by you." 
    else
      #fix-richa use punctuation at the last of message
      flash[:notice] = "#{@game.name} can't be grabbed."
    end
    redirect_to game_path(@game)
  end

  #fix-richa give proper spacing after each operator
  def shortlist
    current_user.games_users.create(:game => @game)
    redirect_with_flash(:notice, "#{@game.name} has been shortlisted by you.", "/")
  end

  #fix-richa why u have not written this method in model
  def check_shortlist_status
    if current_user.shortlisted_games.count.equal? MAX_SHORTLISTED_GAMES
      msg = "Sorry, you can shortlist atmost five games"
    elsif current_user.already_shortlisted @game
      msg = "#{@game.name} has already been shortlisted by you"
    end
    redirect_with_flash(:notice, msg, "/") if msg
  end

  def remove_shortlisted_game
    #fix-pks use load_game filter to find out the game
    @game = current_user.shortlisted_games.find params[:id] 
    current_user.remove_shortlisted_game(@game)
    #fix-pks what http method you are using for user's dashboard. I think dashboard should be private to a user and should not be accessible by other users. 
    redirect_with_flash(:notice, "You have successfully removed #{@game.name} from your shortlisted games list.", dashboard_users_path)
  end

end