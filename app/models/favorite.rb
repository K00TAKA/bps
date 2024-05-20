# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :member
  belongs_to :comment

  validates :member_id, uniqueness: { scope: :comment_id }
end
