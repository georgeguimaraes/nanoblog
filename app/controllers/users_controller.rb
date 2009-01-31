class UsersController < ApplicationController
  # GET /users/new
  def new
    @user = User.new
  end

  # POST /posts
  # POST /posts.xml
  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to(@user)
    else
      format.html { render :action => "new" }
    end
  end
  
  # GET /users/:id
  def show
  
  end
end
