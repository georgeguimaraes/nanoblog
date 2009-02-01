class UserSessionsController < ApplicationController
  # - GET /users/login
  #
  def new
    @user = User.new
  end

  # - POST /users/sessions
  #
  def create
    @user = User.find(:first, :conditions => ["email = ?", params[:user][:email]])
    
    if User.encrypt(params[:user][:password], @user.salt) == @user.hashed_password 
      flash[:notice] = 'Login successfull'
      session[:user_id] = @user.id

      redirect_to(@user)
    else
      @user = User.new(params[:user])
      flash[:warn] = 'Login with error'

      render :action => 'new'
    end
  end

end
