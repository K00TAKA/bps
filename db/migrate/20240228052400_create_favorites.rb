# frozen_string_literal: true

class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :member_id
      t.integer :comment_id
      t.timestamps
    end
  end
end
