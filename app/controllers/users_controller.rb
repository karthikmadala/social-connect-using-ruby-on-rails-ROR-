class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [ :profile ]
  before_action :authenticate_user!

  def index
    # Exclude the current user from the list
    @users = User.where.not(id: current_user.id)
  end

  def profile
    @user = User.find(params[:id])
    @friends = @user.friends
  end
  def friends
    # Fetch only accepted friends of the current user
    @friends = current_user.accepted_friends
  end
  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to home_index_path, alert: "You must be an admin to access this page."
    end
  end
end
