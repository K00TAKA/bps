# frozen_string_literal: true

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
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :name, presence: true
  validates :name_kana, format: { with: /\p{katakana}/ }, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\z/i }, presence: true

  with_options on: :create do |create|
    create.validates :password, length: { in: 6..140 },
    format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i,
    message: 'は英数字の混合である必要があります' },on: :create, presence: true
    create.validates :password_confirmation, length: { in: 6..140 }, presence: true
  end

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
