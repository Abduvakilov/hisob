class CreateCounterParties < ActiveRecord::Migration[5.2]
  def change
    create_table :counter_parties do |t|
      t.string :name
      t.string :company_name
      t.string :phone
      t.string :email
      t.references :district
      t.references :category
      t.boolean :is_supplier
      t.boolean :is_customer
      t.boolean :is_active
      t.text :description
      t.timestamps
    end
  end
end
