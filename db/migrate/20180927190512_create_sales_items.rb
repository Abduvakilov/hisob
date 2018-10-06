class CreateSalesItems < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_items do |t|
      t.references :product, foreign_key: true
      t.integer :amount, null: false
      t.float :price, null: false
      t.references :sale, foreign_key: true

      t.timestamps
    end
  end
end
