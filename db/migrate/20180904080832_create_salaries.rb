class CreateSalaries < ActiveRecord::Migration[5.2]
  def change
    create_table :salaries do |t|
      t.references :employee, foreign_key: true
      t.references :department, foreign_key: true
      t.date       :from_date
      t.float      :amount, null: false
      t.references :currency, foreign_key: true
      t.text       :notes

      t.timestamps
    end
  end
end
