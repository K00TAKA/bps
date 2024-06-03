# frozen_string_literal: true

class Comment < ApplicationRecord
  has_many :favorites, dependent: :destroy
  belongs_to :company
  belongs_to :member
  has_many :notifications, dependent: :destroy

  validates :comment, presence: true, format: { with: /\S/ }

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  def comment_status
    is_active ? "表示" : "非表示"
  end

  def create_notification_favorite!(current_member)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and comment_id = ? and action = ? ", current_member.id, member_id, id, 'favorite'])
    if temp.blank?
      notification = current_member.active_notifications.new(
        comment_id: id,
        visited_id: member_id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end