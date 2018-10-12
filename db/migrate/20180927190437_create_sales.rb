class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :currency, null: false
      t.references :customer, index: true, foreign_key: { to_table: :counter_parties }
      t.date :date, null: false
      t.float :discount
      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.datetime :discarded_at, index: true

      t.timestamps
    end

    create_table :sale_items do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :amount, null: false
      t.float :price, null: false
      t.references :sale, foreign_key: true
    end
  end
end
