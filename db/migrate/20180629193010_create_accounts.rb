class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string     :name, null: false
      t.references :company, foreign_key: true
      t.references :currency, foreign_key: true
      t.boolean    :enable_overdraft
      t.integer    :bank_account_number
      t.text       :notes

      t.timestamps
    end
  end
end
