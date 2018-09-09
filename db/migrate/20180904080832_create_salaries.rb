class CreateSalaries < ActiveRecord::Migration[5.2]
  def change
    create_table :salaries do |t|
      t.references :employee, foreign_key: true
      t.references :department, foreign_key: true
      t.date :from_date, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :salary, null: false

      t.timestamps
    end
  end
end
