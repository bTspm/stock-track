class CreateWatchLists < ActiveRecord::Migration[5.2]
  def change
    create_table :watch_lists do |t|
      t.string :name, null: false, unique: true
      t.text :symbols, array: true, default: []
      t.references :user, null: false, index: true, foreign_key: true

      t.timestamps
    end

    add_index :watch_lists, %i[name user_id], unique: true
  end
end
