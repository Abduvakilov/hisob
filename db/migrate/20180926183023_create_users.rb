class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.references :employee, foreign_key: true
      t.datetime :discarded_at

      t.timestamps
    end
    add_index :users, :discarded_at
  end
end
