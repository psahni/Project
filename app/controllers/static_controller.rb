class StaticController < ApplicationController
  def confirmation
    @user = User.find(params[:id]) 
  end
end
