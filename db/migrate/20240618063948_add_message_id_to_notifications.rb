class AddMessageIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :message_id, :integer
    add_index :notifications, :message_id
  end
end
