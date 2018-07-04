class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.text :notes
      t.float :amount
      t.date :date

      t.timestamps
    end
  end
end
