class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string     :name, null: false
      t.references :parent_category, foreign_key: { to_table: :categories }, index: true
      t.text       :notes

      t.timestamps
    end
  end
end
