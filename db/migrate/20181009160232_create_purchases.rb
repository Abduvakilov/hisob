class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :currency
      t.date :date, null: false
      t.references :supplier, index: true, foreign_key: { to_table: :counter_parties }
      t.float :discount
      t.references :created_by, foreign_key: { to_table: :users }
      t.datetime :discarded_at, index: true

      t.timestamps
    end

    create_table :purchase_items do |t|
      t.references :purchase, null: false, index: true
      t.references :product, null: false, index: true
      t.integer :amount, null: false
      t.float :price, null: false
    end
  end
end
