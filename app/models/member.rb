class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    first_name + last_name
  end

  def member_status
    if is_active == true
      "入会中"
    else
      "退会済み"
    end
  end

end
