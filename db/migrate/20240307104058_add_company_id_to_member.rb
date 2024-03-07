class AddCompanyIdToMember < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :company_id, :integer
  end
end
