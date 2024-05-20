# frozen_string_literal: true

class Comment < ApplicationRecord
  has_many :favorites, dependent: :destroy
  belongs_to :company
  belongs_to :member

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  def comment_status
    if is_active == true
      "表示"
    else
      "非表示"
    end
  end
end
