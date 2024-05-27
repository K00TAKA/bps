# frozen_string_literal: true

class HomesController < ApplicationController
  def top
    @companies = Company.where(is_active: true).order(created_at: :desc).limit(5)
    @announcements = Announcement.order(created_at: :desc).limit(5)
  end

  def about
  end
end
