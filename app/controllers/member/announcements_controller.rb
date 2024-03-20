class Member::AnnouncementsController < ApplicationController

  def index
    @announcements = Announcement.all
  end

end