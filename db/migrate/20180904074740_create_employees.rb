class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.date :birthday
      t.references :department, foreign_key: true
      t.text :notes
      t.boolean :gender
      t.date :hire_date

      t.timestamps
    end
  end
end
