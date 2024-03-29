class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :company, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  def active_for_authentication?
    super && (is_active == true)
  end

  def member_status
    if is_active == true
      "入会中"
    else
      "退会済み"
    end
  end

end
