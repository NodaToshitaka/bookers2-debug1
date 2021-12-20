class RelationshipsController < ApplicationController

  def create
    current_user.follow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end
  
  def follows
    user = User.find(params[:id])
    @users = user.following_user.all
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.follower_user.all
  end
end
