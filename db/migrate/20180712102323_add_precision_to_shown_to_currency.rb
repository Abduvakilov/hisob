class AddPrecisionToShownToCurrency < ActiveRecord::Migration[5.2]
  def change
    add_column :currencies, :precision_to_show, :integer, default: 2
  end
end
