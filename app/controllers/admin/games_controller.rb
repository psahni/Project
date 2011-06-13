class Admin::GamesController < ApplicationController
  layout 'admin'
  before_filter :admin_authenticate
  after_filter :last_uri, :only => [:edit, :show, :update]
  before_filter :load_game, :except => [:index, :new, :create,:browse_by_platform,:browse_by_category]         
  
  def index
    @games = Game.paginate :page => params[:page], :order => 'name'
  end

  def new
    @game  = Game.new 
  end

  def create
    begin
      @game = Game.new(params[:game])
    rescue Exception => e
      @game = Game.new
      flash.now[:error] = "Category is not included in the list."
      return render :action => :new
    end
    if @game.save
      redirect_with_flash(:notice, "Game has been created successfully", admin_game_path(@game))
    else
      render :action => 'new'
    end
  end
  
  def edit
    @prev_image = @game.image.url(:medium)    
  end

  def update
    @prev_image ||= @game.image.url(:medium)
    if @game.update_attributes(params[:game])
     redirect_with_flash(:notice,"Game has been updated successfully", admin_game_path(@game))
    else
      render :action => 'edit'
    end
  end     
  
  def show
  end

  def destroy
    @game.destroy
    redirect_with_flash(:notice,"Game has been deleted successfully", admin_games_path)
  end                                      

  def remove_image
    #fix - pks proper spacing
    @game.update_attribute(:image, nil)
    @back_page, session[:uri] = session[:uri], nil
    #fix - pks proper spacing and punctuation at the end of message
    redirect_with_flash(:notice, "Image has been removed", @back_page || game_path(@game))
  end




end
