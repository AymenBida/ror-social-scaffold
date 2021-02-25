class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @friendship = current_user.friendships.build(friend_id: @user.id, status: 'pending')
    if @friendship.save
      flash[:notice] = "Your friend request to #{@user.name} is sent!"
      redirect_to users_path
    else
      flash[:alert] = "We didn't succeed to send your request!"
      render '/users'
    end
  end

  def index
    @user = User.find(params[:user_id])
  end
end
