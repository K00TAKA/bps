# frozen_string_literal: true

class Comment < ApplicationRecord
  has_many :favorites, dependent: :destroy
  belongs_to :company
  belongs_to :member

  validates :comment, presence: true, format: { with: /\S/, message: "コメントを入力してください。" }

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  def comment_status
    is_active ? "表示" : "非表示"
  end
end