# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :member
  belongs_to :room
  has_many :notifications, dependent: :destroy
end
