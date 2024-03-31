class HomesController < ApplicationController

  def top
    #新着5件表示する
    @companies = Company.where(is_active: true).order(created_at: :desc).limit(5)
    # if company.is_active?
    #   Company..limit(5)
    @announcements = Announcement.order(created_at: :desc).limit(5)
  end

  def about

  end

end
