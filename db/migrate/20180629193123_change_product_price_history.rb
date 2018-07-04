class ChangeProductPriceHistory < ActiveRecord::Migration[5.2]
  def change
    create_table :price_category do |t|
      t.string :name
      t.text   :description
    end
    add_reference :product_price_histories, :currency, index: true
    add_reference :product_price_histories, :price_category, index: true

  end
end
