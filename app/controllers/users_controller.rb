class UsersController < ApplicationController
  
  #fix-pks insert spaces around an operator or comma
  before_filter :authorize,:only => [:dashboard, :personal_details,
                                      :subs_details, :change_password, :new_password]
                                      
  #Remember: if the user is logged in then the user should not be able to access this actions
  #fix-pks insert spaces around an operator or comma
  before_filter :already_logged_in, :only => [:new, :create, :forgot, :reset]

  #fix-pks insert spaces around an operator or comma                                                                                
  before_filter :load_user, :only => [:personal_details, :subs_details, :new_password, :dashboard]
  
  include Authentication

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user].merge({:identification_token => User.make_identification_token}))
    #pks - use proper indentation
    @user.save ? (redirect_to confirmation_path(@user)) : (render :action => 'new') 
  end

  def forgot
    if request.post?
      return flash.now[:error] = "Please enter your email." if params[:user] && params[:user][:email].blank?
      @user = User.find_by_email(params[:user][:email])
      if @user
        @user.create_reset_code
        #fix-pks insert spaces around an operator or comma
        redirect_with_flash(:notice,"Reset code has been sent to you at #{@user.email}.", games_path)
      else
        flash.now[:error] = "There is no account associated with this email address."
      end 
    end
  end

  def reset
    @user = User.find_by_reset_code(params[:reset_code])
    #fix-pks insert spaces around an operator or comma also use return
    redirect_with_flash(:error, "Invalid URL. Please copy the reset password link sent to your email and try again.", "/") unless @user
    return unless request.post?
    if @user.update_attributes(params[:user])
      @user.delete_reset_code
      #fix-pks insert spaces around an operator or comma
      redirect_with_flash(:notice, "Password has been changed.", login_path)
    end 
  end
  
  #fix-pks other users can also access a user's dashboard?
  def new_password;end

  def change_password
    #fix - richa why r u checking for current user while you have already put authorize filter 
    #fix - richa why r u assigning current_user to @user variable
    @user = current_user
    if params[:old_password].blank?  
      redirect_with_flash(:notice, "Please enter your current password", new_password_user_path(current_user))
    else
      #fix - please read the restful authentication lib, you will find a method authenticated? there
      if User.authenticate(current_user.email, params[:old_password])
        if current_user.update_attributes(params[:user])
          #fix-richa insert spaces around an operator or comma
          redirect_with_flash(:notice, "Password changed successfully.", personal_details_user_path(current_user))
        else
          render :action => :new_password
        end
      else
        redirect_with_flash(:notice, "You have entered wrong password.", new_password_user_path(current_user))
      end
    end
  end

  private
 
  def dashboard;end

  def personal_details; end
  
  def subs_details;end
    
  #fix-richa move this to application controller
  #fix-richa i dont understand the purpose of making this method. also u r not using it anywhere
end
