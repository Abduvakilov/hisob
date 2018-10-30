class CreateCounterParties < ActiveRecord::Migration[5.2]
  def change
    create_table :counter_parties do |t|
      t.string      :short_name
      t.string      :company_name
      t.string      :primary_person
      t.string      :phone
      t.string      :email
      t.references  :district, foreign_key: true
      t.references  :category, foreign_key: true
      t.boolean     :is_supplier, index: true
      t.boolean     :is_customer, index: true
      t.text        :notes

      t.timestamps
    end
  end
end
