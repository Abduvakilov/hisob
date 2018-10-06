class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :customer, index: true, foreign_key: { to_table: :counter_parties }
      t.date :date, null: false
      t.float :discount
      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
