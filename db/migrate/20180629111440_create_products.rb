class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string     :name, null: false
      t.references :company, foreign_key: true
      t.references :category, foreign_key: true
      t.boolean    :is_for_sale, index: true
      t.text       :notes

      t.timestamps
    end
    create_table :price_histories do |t|
      t.date       :date, null: false
      t.float      :price
      t.references :product, foreign_key: true
      t.references :category, foreign_key: true # product price category
      t.references :currency, foreign_key: true
      t.text       :notes

      t.timestamps
    end
  end
end
