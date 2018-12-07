class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.references :counter_party, foreign_key: true
      t.string     :name, null: false
      t.references :price_type, foreign_key: { to_table: :categories }, index: true
      t.references :currency, foreign_key: true, index: true
      t.date       :start_date
      t.date       :due_date
      t.text       :notes

      t.datetime   :discarded_at, index: true
      t.timestamps
    end
  end
end
