class FriendshipsController < ApplicationController
  before_action :check_user!, only: [:index]

  def create
    @user = User.find(params[:user_id])
    @already_invited = current_user.pending_friends.select { |user| user.id == @user.id }
    @friendship = current_user.friendships.build(friend_id: @user.id, status: 'pending')
    if !@already_invited.empty?
      flash[:alert] = "You already sent a request to #{@user.name}!"
    elsif @friendship.save
      flash[:notice] = "Your friend request to #{@user.name} is sent!"
    else
      flash[:alert] = "We didn't succeed to send your request!"
    end
    redirect_to users_path
  end

  def accept
    @friend = User.find(params[:user_id])
    if current_user.confirm_friend(@friend)
      Friendship.create(user_id: current_user.id, friend_id: @friend.id, status: 'confirmed')
      flash[:notice] = "You are now friends with #{@friend.name}!"
    else
      flash[:alert] = "Sorry, we couldn't process your request!"
    end
    redirect_to user_friendships_path(current_user)
  end

  def deny
    @friend = User.find(params[:user_id])
    if current_user.deny_friend(@friend)
      flash[:notice] = "You just denied the invitation from #{@friend.name}!"
    else
      flash[:alert] = "Sorry, we couldn't process your request!"
    end
    redirect_to user_friendships_path(current_user)
  end

  def index
    @user = User.find(params[:user_id])
  end

  private

  def check_user!
    @authenticated_user = User.find(params[:user_id])
    redirect_to user_friendships_path(current_user) unless @authenticated_user == current_user
  end
end
