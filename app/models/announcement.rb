# frozen_string_literal: true

class Announcement < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
end
