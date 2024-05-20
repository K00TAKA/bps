# frozen_string_literal: true

class CreateAnnouncements < ActiveRecord::Migration[6.1]
  def change
    create_table :announcements do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.boolean "is_active", default: true, null: false
      t.integer "admin_id"
      t.timestamps
    end
  end
end
