class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.references :company
      t.boolean :product_for_sale, default: false
      t.boolean :active, default: true
      
      t.timestamps
    end
  end
end
