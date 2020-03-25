class CreateExchanges < ActiveRecord::Migration[5.2]
  def up
    create_table :exchanges do |t|
      t.citext :code, null: false, uniq: true
      t.citext :country, null: false
      t.citext :name, null: false
    end

    add_index :exchanges, :country
    add_index :exchanges, %i[code country], unique: true
  end

  def down
    if index_exists? :exchanges, :code
      remove_index :exchanges, name: :index_exchanges_on_code
    end
    if index_exists? :exchanges, :country
      remove_index :exchanges, name: :index_exchanges_on_country
    end
    drop_table :exchanges if table_exists? :exchanges
  end
end
