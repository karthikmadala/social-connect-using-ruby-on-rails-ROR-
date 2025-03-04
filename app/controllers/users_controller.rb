class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:destroy]

  def index
    @users = User.where.not(id: current_user.id)
    @friend_requests = current_user.received_friend_requests.pending.includes(:user)
    if params[:query].present?
      search_term = "%#{params[:query]}%"
      @users = User.where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ? OR phone ILIKE ?", 
                              search_term, search_term, search_term, search_term)
    end
  end

  def profile
    @user = User.find(params[:id])
    @friends = @user.friends
  end

  def friends
    @friends = current_user.friends
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin?
      redirect_to users_path, alert: "You cannot delete an admin user."
    else
      @user.destroy
      redirect_to users_path, notice: "User successfully deleted."
    end
  end

  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to home_index_path, alert: "You must be an admin to access this page."
    end
  end
end
