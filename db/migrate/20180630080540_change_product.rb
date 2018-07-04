class ChangeProduct < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :product_for_sale, :is_for_sale
    rename_column :products, :active, :is_active
    add_reference :products, :category
  end
end
