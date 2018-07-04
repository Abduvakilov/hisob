class ChangeTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :type, :integer
    add_reference :transactions, :counter_party
    add_column :transactions, :coefficient, :float
    add_reference :transactions, :account
    add_column :transactions, :reference_id, :integer
    add_column :transactions, :reference_type, :string

  end
end
