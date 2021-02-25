class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @already_invited = current_user.pending_friends.select { |user| user.id == @user.id }
    @friendship = current_user.friendships.build(friend_id: @user.id, status: 'pending')
    if !@already_invited.empty?
      flash[:alert] = "You already sent a request to #{@user.name}!"
      redirect_to users_path
    else
      if @friendship.save
        flash[:notice] = "Your friend request to #{@user.name} is sent!"
        redirect_to users_path
      else
        flash[:alert] = "We didn't succeed to send your request!"
        redirect_to users_path
      end
    end
  end

  def index
    @user = User.find(params[:user_id])
  end
end
