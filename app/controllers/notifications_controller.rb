class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def recent
    @notifications = current_user.notifications.unread.limit(5)
    render partial: "notifications/notifications_list", locals: { notifications: @notifications }
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    @notification.update(read: true)
    redirect_back fallback_location: notifications_path
  end
end
