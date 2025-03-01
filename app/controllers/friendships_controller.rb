class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.accepted_friends
    @pending_requests = current_user.pending_friendships.includes(:friend)
  end

  def requests
    # Fetch only pending requests sent to the current user (User B)
    @friend_requests = current_user.received_friend_requests.pending.includes(:user)
  end

  def create
    friend = User.find(params[:friend_id])
    existing_request = current_user.sent_friend_requests.find_by(friend: friend)

    if existing_request.nil?
      @friendship = current_user.sent_friend_requests.build(friend: friend, status: "pending")
      if @friendship.save
        redirect_to users_path, notice: "Friend request sent!"
      else
        redirect_to users_path, alert: "Could not send request."
      end
    else
      redirect_to users_path, alert: "You have already sent a request."
    end
  end

  def accept
    friendship = Friendship.find(params[:id])
    # Ensure only the recipient (User B) can accept the request
    if friendship.friend == current_user
      Friendship.transaction do
        friendship.update!(status: "accepted")
        Friendship.create!(user: current_user, friend: friendship.user, status: "accepted") # Ensure mutual friendship
      end
      redirect_to friend_requests_path, notice: "Friend request accepted!"
    else
      redirect_to root_path, alert: "Unauthorized!"
    end
  end

  def reject
    friendship = Friendship.find(params[:id])
    # Ensure only the recipient (User B) can reject the request
    if friendship.friend == current_user
      friendship.destroy
      redirect_to friend_requests_path, notice: "Friend request rejected."
    else
      redirect_to root_path, alert: "Unauthorized!"
    end
  end

  def cancel
    # Ensure only the sender (User A) can cancel the request
    friendship = current_user.sent_friend_requests.find_by(friend_id: params[:friend_id], status: "pending")
    if friendship
      friendship.destroy
      redirect_to users_path, notice: "Friend request canceled."
    else
      redirect_to users_path, alert: "No pending request found."
    end
  end

  def unfriend
    # Ensure only the current user can unfriend someone
    friendship = Friendship.between(current_user, User.find(params[:friend_id])).first
    if friendship
      friendship.destroy
      redirect_to friends_path, notice: "You are no longer friends."
    else
      redirect_to friends_path, alert: "Friendship not found."
    end
  end
end