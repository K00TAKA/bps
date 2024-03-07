class AddMemberIdToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :member_id, :integer
  end
end
