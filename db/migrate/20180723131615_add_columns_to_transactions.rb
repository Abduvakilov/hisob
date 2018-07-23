class AddColumnsToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :counter_account, :reference
    add_column :transactions, :rate, :float
  end
end
