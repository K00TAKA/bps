class Comment < ApplicationRecord
  
  has_many :favorites, dependent: :destroy
  
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
