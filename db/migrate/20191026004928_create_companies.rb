class CreateCompanies < ActiveRecord::Migration[5.2]
  def up
    create_table :companies do |t|
      t.citext :symbol, null: false
      t.citext :name, null: false
      t.citext :security_name, null: false
      t.citext :sector, null: false
      t.citext :industry, null: false
      t.integer :address_id
      t.citext :phone
      t.integer :employees
      t.citext :website
      t.text :description
      t.integer :sic_code

      t.references :address, null: true, index: true, foreign_key: true
      t.references :exchange, null: false, index: true, foreign_key: true
      t.references :issuer_type, null: false, index: true, foreign_key: true

      t.timestamps
    end
    add_index :companies, %i[symbol exchange_id], unique: true
    add_index :companies, :sector
    add_index :companies, :industry
  end

  def down
    if index_exists? :companies, :sector
      remove_index :companies, name: :index_companies_on_sector
    end
    if index_exists? :companies, :industry
      remove_index :companies, name: :index_companies_on_industry
    end
    if index_exists? :companies, :symbol
      remove_index :companies, name: :index_companies_on_symbol
    end

    remove_reference :companies, :address, index: true, foreign_key: truec
    remove_reference :companies, :exchange, index: true, foreign_key: true
    remove_reference :companies, :issuer_type, index: true, foreign_key: true

    drop_table :companies if table_exists? :companies
  end
end
