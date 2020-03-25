class CreateAddresses < ActiveRecord::Migration[5.2]
  def up
    enable_extension :citext

    create_table :addresses do |t|
      t.citext :line_1, null: false
      t.citext :line_2
      t.citext :city
      t.citext :state
      t.citext :country, null: false
      t.citext :zip_code

      t.timestamps
    end

    add_index :addresses, :country
    add_index :addresses, :state
  end

  def down
    if index_exists? :addresses, :country
      remove_index :addresses, name: :index_addresses_on_country
    end
    if index_exists? :addresses, :state
      remove_index :addresses, name: :index_addresses_on_state
    end
    drop_table :addresses if table_exists? :addresses
  end
end
