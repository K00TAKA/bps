class AddCompanyIdToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :company_id, :integer
  end
end
