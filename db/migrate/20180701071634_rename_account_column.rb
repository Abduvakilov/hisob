class RenameAccountColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :accounts, :is_bank_account?, :is_bank_account
    rename_column :transactions, :type, :type_id
  end
end
