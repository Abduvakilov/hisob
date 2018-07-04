class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string  :name
      t.text  :description
      t.references :parent_category, foreign_key: { to_table: :categories }, index: true
      t.integer :type_id
      t.timestamps
    end
  end
end
