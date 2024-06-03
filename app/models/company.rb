# frozen_string_literal: true

class Company < ApplicationRecord
  belongs_to :member
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :company, presence: true
  validates :company_kana, format: { with: /\p{katakana}/ }, presence: true
  validates :genre, presence: true
  validates :post_code, numericality: { only_integer: true }, format: { with: /\A\d{7}\z/ }, presence: true
  validates :address, presence: true
  validates :tel, numericality: { only_integer: true }, format: { with: /\A\d{10,11}\z/ }, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\z/i }, presence: true

  enum genre: { 製造業: 0, 建設業: 1, 電気・ガス: 2,  運輸・通信業: 3, 卸売・小売業: 4, 飲食業: 5, 不動産業: 6, サービス業: 7, 金融・保険業: 8, 鉱業: 9, 農林: 10, 水産: 11 }

  def self.search_for(content, method)
    if method == "perfect"
      Company.where(company: content)
    elsif method == "forward"
      Company.where("company LIKE ?", content + "%")
    elsif method == "backward"
      Compnay.where("company LIKE ?", "%" + content)
    else
      Company.where("company LIKE ?", "%" + content + "%")
    end
  end
end
