class CreateAnnouncements < ActiveRecord::Migration[6.1]
  def change
    create_table :announcements do |t|
      t.string :body, null: false
      t.references :admin, null: false, foreign_key: true
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
