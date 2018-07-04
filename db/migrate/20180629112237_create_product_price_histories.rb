class CreateProductPriceHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :product_price_histories do |t|
      t.datetime   :date
      t.float      :price
      t.references :product

      t.timestamps
    end
  end
end
