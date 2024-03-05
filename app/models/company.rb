class Company < ApplicationRecord

  belongs_to :member
  belongs_to :genre, optional: true
  has_one_attached :image
  has_many :comments

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end


  def company_status
    if is_active == true
      "表示"
    else
      "非表示"
    end
  end

end
