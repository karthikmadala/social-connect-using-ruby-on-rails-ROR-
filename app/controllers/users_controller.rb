class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # Exclude the current user from the list
    @users = User.where.not(id: current_user.id)
  end

  def friends
    # Fetch only accepted friends of the current user
    @friends = current_user.accepted_friends
  end
end