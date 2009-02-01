class FollowersController < ApplicationController
  
  def create
    @followed = User.find(params[:user_id])
    @followed.followers << @current_user
    redirect_to @followed
  end
  
  def destroy
    @followed = User.find(params[:user_id])
    @followed.followers.delete @current_user
    redirect_to @followed
  end
  
end
