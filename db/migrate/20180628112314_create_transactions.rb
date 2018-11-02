class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t| # TODO Divide to Income Expense Replace
      t.datetime    :datetime, null: false
      t.float       :amount, null: false
      t.integer     :type_id, null: false, index: true, limit: 64
      t.references  :counter_party, foreign_key: true
      t.references  :employee, foreign_key: true
      t.references  :contract, foreign_key: true
      t.float       :accepted_as_amount
      t.references  :accepted_as_currency, foreign_key: { to_table: :currencies }
      t.references  :account, foreign_key: true
      t.references  :counter_account, foreign_key: { to_table: :accounts }
      t.float       :rate
      t.references  :asked_currency, foreign_key: { to_table: :currencies }
      t.text        :notes

      t.timestamps
    end
  end
end
