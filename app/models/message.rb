class Message < ApplicationRecord
  belongs_to :member
  belongs_to :room
  has_many :notifications, dependent: :destroy

  after_create :create_notification

  private

  def create_notification
    room.entries.where.not(member_id: member_id).each do |entry|
      Notification.create(
        room_id: room_id,
        visited_id: entry.member_id,
        visitor_id: member_id,
        action: 'message'
      )
    end
  end
end