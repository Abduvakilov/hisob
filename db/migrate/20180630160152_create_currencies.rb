class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.integer :precision, default: 2

      t.timestamps
    end
  end
end
