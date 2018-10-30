class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :contract, null: false, foreign_key: true
      t.datetime   :datetime, null: false
      t.float      :discount
      t.datetime   :discarded_at, index: true
      t.text       :notes

      t.timestamps
    end

    create_table :sale_items do |t|
      t.references :product, null: false, foreign_key: true
      t.integer    :amount, null: false
      t.float      :price, null: false
      t.references :sale, foreign_key: true
    end
  end
end
