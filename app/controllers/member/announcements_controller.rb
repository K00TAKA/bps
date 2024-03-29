class Member::AnnouncementsController < ApplicationController

  def index
    @announcements = Announcement.all.page(params[:page]).per(10)
  end

end