class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string     :name, null: false
      t.references :company, foreign_key: true
      t.text       :notes

      t.timestamps
    end
  end
end
