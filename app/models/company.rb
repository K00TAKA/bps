class Company < ApplicationRecord

  belongs_to :member
  belongs_to :genre, optional: true
  has_one_attached :image
  has_many :comments, dependent: :destroy

  def self.search_for(content, method)
    if method == 'perfect'
      Company.where(company: content)
    elsif method == 'forward'
      Company.where('company LIKE ?', content + '%')
    elsif method == 'backward'
      Compnay.where('company LIKE ?', '%' + content)
    else
      Company.where('company LIKE ?', '%' + content + '%')
    end
  end

end
