class RenameAccountColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :accounts, :is_bank_account?, :is_bank_account
  end
end
