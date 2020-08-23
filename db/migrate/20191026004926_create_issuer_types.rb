class CreateIssuerTypes < ActiveRecord::Migration[5.2]
  def up
    create_table :issuer_types do |t|
      t.citext :code, null: false, uniq: true
      t.citext :name, null: false, uniq: true

      t.timestamps
    end

    add_index :issuer_types, :code, unique: true
    add_index :issuer_types, :name, unique: true
  end

  def down
    if index_exists? :issuer_types, :code
      remove_index :issuer_types, name: :index_issuer_types_on_code
    end
    if index_exists? :issuer_types, :country
      remove_index :issuer_types, name: :index_issuer_types_on_country
    end
    drop_table :issuer_types if table_exists? :issuer_types
  end
end
