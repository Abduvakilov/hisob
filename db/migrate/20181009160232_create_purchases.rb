class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.datetime   :datetime, null: false
      t.references :contract, null: false, foreign_key: true
      t.float      :discount
      t.datetime   :discarded_at, index: true
      t.text       :notes

      t.timestamps
    end

    create_table :purchase_items do |t|
      t.references :purchase, null: false, index: true
      t.references :product, null: false, index: true
      t.integer    :amount, null: false
      t.float      :price, null: false
    end
  end
end
