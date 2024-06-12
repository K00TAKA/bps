class Member::NotificationsController < ApplicationController
  before_action :authenticate_member!

  def index
    @notifications = current_member.passive_notifications.where(checked: false).includes(:visitor, :visited).order(created_at: :desc)
  end

  def mark_as_read
    notification = Notification.find(params[:id])
    notification.update(checked: true)
    redirect_to notifications_path, notice: '通知を既読にしました。'
  end
end