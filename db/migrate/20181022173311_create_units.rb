class CreateUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :units do |t|
      t.string     :short_name, null: false
      t.string     :long_name, null: false
      t.references :base_unit, foreign_key: { to_table: :units }
      t.float      :ratio_to_base_unit
      t.datetime   :discarded_at, index: true

      t.timestamps
    end
    add_column    :products, :include_base_unit, :boolean
    add_reference :products, :unit
  end
end
