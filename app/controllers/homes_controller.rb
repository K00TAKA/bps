class HomesController < ApplicationController

  def top
    @companies = Company.order(created_at: :desc).limit(5)
    @announcements = Announcement.order(created_at: :desc).limit(5)
  end

  def about
  end

end
