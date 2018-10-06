class AddAskedCurrencyColumnToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :asked_currency, foreign_key: { to_table: :currency }
  end
end
