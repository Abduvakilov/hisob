class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.references :company
      t.references :currency
      t.boolean :is_bank_account?
      t.integer :bank_account_number

      t.timestamps
    end
  end
end
