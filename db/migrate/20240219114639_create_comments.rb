# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :comment, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
