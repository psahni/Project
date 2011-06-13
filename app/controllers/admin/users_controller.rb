class Admin::UsersController < ApplicationController
  layout "admin"
  before_filter :admin_authenticate
  before_filter :last_uri, :only => [:index, :show]
  
  def index
    @users =  User.paginate :page => params[:page], :order => 'name'
  end
  
  def activate_account
    @user = User.find_by_id(params[:id])
    msg = @user.updated ? "Account has been activated for #{@user.name}." : "Account can not be activated."
    redirect_with_flash(:notice, msg, session[:uri])
  end
  
  def renew_subscription
    @user = User.find_by_id(params[:id])
    if @user
      msg = @user.renewed ? "Subscription has been renewed for #{@user.name}." : "Subscription can not be renewed."
    else  
      msg = "No user found."
    end
    redirect_with_flash(:notice, msg, session[:uri])
  end
  
  def deactivate_account
    @user = User.find(params[:id])        
    if @user.update_attribute(:is_active, false)
      SubscriberMailer.deliver_account_deactivation(@user)
      flash[:notice] = "Account has been deactivated for #{@user.name}."
    else
      flash[:notice] = "Account can't be deactivated"
    end
    redirect_to session[:uri]
  end
  
  def search
    @user = User.find_by_email(params[:email])
    if params[:email].blank?
      redirect_with_flash(:notice, "Please enter Email Id", session[:uri])
    elsif @user
      redirect_to admin_user_path(@user)
    else
      redirect_with_flash(:notice, "There is no user with this email id", session[:uri])
    end
  end
  
  def show
    @user = User.find(params[:id])
    @sub_games =  @user.subscribed_games.paginate :page => params[:page], :order => 'returned_at DESC'
  end
  
  def rent_game
    @user = User.find_by_id(params[:id])
    if @user
      if @user.grabbed_game.nil?
        redirect_with_flash(:notice, "No grabbed game", session[:uri])
      else
        if !@user.rented_game
          gu = GamesUser.find_by_user_id(@user.id, :conditions => {:status => RENTING_STATUS[:grabbed]})
          gu.update_attributes(:status => RENTING_STATUS[:rented], :rented_at => Time.now)
          flash[:notice] = "Game has been issued to #{@user.name}"
        else
          flash[:notice] = "Game can't be issued to #{@user.name}. The previous game hasn't been returned."
        end
        redirect_to admin_user_path(@user)
      end
    else
      redirect_with_flash(:notice, "No user exists", session[:uri])
    end
  end
  
  def return_game
    @user = User.find_by_id(params[:id])
    if !@user
      redirect_with_flash(:notice, "No user exists", session[:uri])
    else
      if @user.rented_game.nil?
        flash[:notice] = "No rented game"
      else
        gu = GamesUser.find_by_user_id(@user.id, :conditions => {:status => RENTING_STATUS[:rented]})
        @game = gu.game
        gu.update_attributes(:status => RENTING_STATUS[:subscribed], :returned_at => Time.now)
        GamesUser.notify_users(@game)
        flash[:notice] = "Game has been returned"
      end
      redirect_to admin_user_path(@user)
    end
  end
  
  def send_notifications
    GamesUser.remove_those_who_grabbed_2days_ago_notify_those_who_shortlisted
    GamesUser.notified_but_not_grabbed
    User.send_renew_subscription_notification
    User.deactivate_if_subscription_exceeds_one_month
  end
 
  #pks - make a single method for all these kind of methods and move that to application controller
end
