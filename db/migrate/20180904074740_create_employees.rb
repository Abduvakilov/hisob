class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.references :department, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true
      t.text :notes
      t.boolean :gender
      t.date :hire_date

      t.timestamps
    end
  end
end
