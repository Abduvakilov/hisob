class CreateDistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :districts do |t|
      t.string     :name, null: false
      t.references :parent_district, foreign_key: { to_table: :districts }
      t.text       :notes

      t.timestamps
    end
  end
end
