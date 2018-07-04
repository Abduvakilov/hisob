class CreateDistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :districts do |t|
      t.string :name
      t.boolean :is_active
      t.references :district
      t.timestamps
    end
  end
end
