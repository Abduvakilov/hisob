class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :units do |t|
      t.string     :short_name, null: false
      t.string     :long_name, null: false
      t.references :base_unit, foreign_key: { to_table: :units }
      t.float      :ratio_to_base_unit
      t.datetime   :discarded_at, index: true

      t.timestamps
    end

    create_table :products do |t|
      t.string     :name, null: false
      t.references :unit
      t.boolean    :include_base_unit
      t.references :company, foreign_key: true
      t.references :counter_party, foreign_key: true
      t.boolean    :is_for_sale, index: true
      t.references :category, foreign_key: true
      t.text       :notes

      t.timestamps
    end

    create_table :prices do |t|
      t.date       :date, null: false
      t.references :product, foreign_key: true
      t.references :category, foreign_key: true
      t.float      :price
      t.references :currency, foreign_key: true
      t.references :price_category, foreign_key: { to_table: :categories }
      t.text       :notes

      t.timestamps
    end
  end
end
