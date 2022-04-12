class ChangeBankAccountNumberColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column :accounts, :bank_account_number, :string
  end
end
