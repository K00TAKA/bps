# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :member
  belongs_to :comment

  validates :member_id, uniqueness: { scope: :comment_id }

  after_create :create_notification

  private

  def create_notification
    Notification.create(
      visitor_id: member_id,
      visited_id: comment.member_id,
      comment_id: comment_id,
      action: 'favorite'
    )
  end
end