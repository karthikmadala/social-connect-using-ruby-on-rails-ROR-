class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends
    @pending_requests = current_user.pending_friendships.includes(:friend)
  end

  def requests
    @friend_requests = current_user.received_friend_requests.pending.includes(:user)
  end

  def create
    friend = User.find(params[:friend_id])

    if Friendship.between(current_user, friend).exists?
      redirect_to users_path, alert: "Friend request already sent or you are already friends."
    else
      @friendship = current_user.sent_friend_requests.build(friend: friend, status: "pending")
      if @friendship.save
        Notification.create!(user: friend, sender: current_user, message: "You have a new friend request.")
        broadcast_notification(friend, "You have a new friend request from #{current_user.name}.")
        redirect_to users_path, notice: "Friend request sent!"
      else
        redirect_to users_path, alert: "Could not send request."
      end
    end
  end

  def accept
    friendship = Friendship.find(params[:id])
    if friendship.friend == current_user
      Friendship.transaction do
        friendship.update!(status: "accepted")
        Friendship.create!(user: current_user, friend: friendship.user, status: "accepted")
      end
      Notification.create!(user: friendship.user, sender: current_user, message: "#{current_user.name} accepted your friend request.")
      broadcast_notification(friendship.user, "#{current_user.name} accepted your friend request.")
      redirect_to friend_requests_path, notice: "Friend request accepted!"
    else
      redirect_to root_path, alert: "Unauthorized!"
    end
  end

  def reject
    friendship = Friendship.find(params[:id])
    if friendship.friend == current_user
      friendship.destroy
      redirect_to friend_requests_path, notice: "Friend request rejected."
    else
      redirect_to root_path, alert: "Unauthorized!"
    end
  end

  def cancel
    friendship = current_user.sent_friend_requests.find_by(friend_id: params[:friend_id], status: "pending")
    if friendship
      friendship.destroy
      redirect_to users_path, notice: "Friend request canceled."
    else
      redirect_to users_path, alert: "No pending request found."
    end
  end

  def unfriend
    friend = User.find(params[:friend_id])
    friendships = Friendship.between(current_user, friend)

    if friendships.any?
      friendships.destroy_all
      redirect_to users_path, notice: "You are no longer friends."
    else
      redirect_to users_path, alert: "Friendship not found."
    end
  end

  private

  def broadcast_notification(user, message)
    ActionCable.server.broadcast("notifications_#{user.id}", { message: message })
  end
end
