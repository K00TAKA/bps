class AddMemberIdToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :member_id, :integer, null: false
  end
end
