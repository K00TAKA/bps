class Member::NotificationsController < ApplicationController
  def index
    @notifications = current_member.passive_notifications
  end
end