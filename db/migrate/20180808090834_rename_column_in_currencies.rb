class RenameColumnInCurrencies < ActiveRecord::Migration[5.2]
  def change
  	rename_column :currencies, :precision_to_show, :precision
  end
end
