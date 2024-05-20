# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :member
  belongs_to :room
end
