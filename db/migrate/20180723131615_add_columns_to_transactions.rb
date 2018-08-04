class AddColumnsToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :counter_account_id, :integer
    add_column :transactions, :rate, :float
  end
end
