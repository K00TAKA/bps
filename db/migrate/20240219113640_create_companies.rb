class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :company, null: false
      t.string :company_kana, null: false
      t.string :date_of_establishment, null: false
      t.string :introduction, null: false
      t.string :post_code, null: false
      t.string :address, null: false
      t.string :tel, null: false
      t.string :email, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
      t.integer :genre, null: false, limit: 1
    end
  end
end
