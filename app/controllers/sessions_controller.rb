class SessionsController < ApplicationController
  
  before_filter :already_logged_in, :only => [:new, :create]
  before_filter :authorize, :only => :destroy
  
  def new;end

  def create
    #fix-pks why r u using this line if u are already filtering this action for logged in user
    user = User.authenticate(params[:email], params[:password])
    if user
      if user.is_active
        self.current_user = user
        #fix-pks insert spaces around an operator or comma
        uri, session[:original_uri] = session[:original_uri], nil
        new_cookie_flag = (params[:remember_me] == "1")
        handle_remember_cookie! new_cookie_flag
        #fix-pks insert spaces around an operator or comma
        redirect_with_flash(:notice,"Logged in successfully", (uri || dashboard_users_path))
      else
        #fix-pks insert spaces around an operator or comma
        redirect_with_flash(:notice,"Your account has not been activated yet.", '/')
      end
    else
      #fix-pks it should have punctuation
      flash.now[:error] = "Invalid email/password combination."
      @email, @remember_me = params[:email], params[:remember_me]
      render :action => "new"
    end
  end
  
  def destroy
    #fix-pks why r u using logged_in? method here   
      current_user.forget_me
      logout_killing_session!
      redirect_with_flash(:notice,"Logged out successfully",'/')
  end

end
