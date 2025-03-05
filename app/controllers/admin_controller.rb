class AdminController < ApplicationController
  before_action :authenticate_admin!

  def dashboard
    @users= User.all
  end

  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to home_index_path, alert: "You must be an admin to access this page."
    end
  end
end
