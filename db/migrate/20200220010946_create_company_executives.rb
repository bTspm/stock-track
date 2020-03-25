class CreateCompanyExecutives < ActiveRecord::Migration[5.2]
  def up
    create_table :company_executives do |t|
      t.integer :age
      t.citext :name, null: false
      t.integer :since
      t.text :titles, array: true, default: []
      t.references :company, null: false, index: true, foreign_key: true

      t.timestamps
    end

    add_index :company_executives, :name
    add_index :company_executives, :titles
    add_index :company_executives, :since
  end

  def down
    if index_exists? :company_executives, :name
      remove_index :company_executives, name: :index_company_executives_on_name
    end
    if index_exists? :company_executives, :titles
      remove_index :company_executives, name: :index_company_executives_on_titles
    end
    if index_exists? :company_executives, :since
      remove_index :company_executives, name: :index_company_executives_on_since
    end

    remove_reference :company_executives, :company, index: true, foreign_key: true

    drop_table :company_executives if table_exists? :company_executives
  end

end
