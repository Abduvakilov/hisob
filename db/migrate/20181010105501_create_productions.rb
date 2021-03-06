class CreateProductions < ActiveRecord::Migration[5.2]
  def change
    create_table :productions do |t|
      t.date     :date, null: false
      t.text     :notes

      t.datetime :discarded_at, index: true
      t.timestamps
    end

    create_table :production_items do |t|
      t.references :production, null: false, index: true
      t.references :product, null: false, index: true
      t.integer :amount, null: false
    end
  end
end
