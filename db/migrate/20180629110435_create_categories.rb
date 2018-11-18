class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string     :name, null: false
      t.references :parent_category, foreign_key: { to_table: :categories }
      t.string     :for, index: true # Price  or Expense category?
      t.text       :notes

      t.timestamps
    end
  end
end
