class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.string     :name, null: false
      t.references :counter_party, foreign_key: true
      t.references :category, foreign_key: true
      t.references :currency, foreign_key: true
      t.date       :start_date
      t.date       :due_date
      t.datetime   :discarded_at, index: true
      t.text       :notes

      t.timestamps
    end
  end
end
