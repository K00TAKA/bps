# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :member
  belongs_to :room
end
