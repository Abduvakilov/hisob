class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.references :employee, foreign_key: true
      t.boolean    :is_admin
      t.text       :notes

      t.text       :settings
      t.datetime   :discarded_at, index: true
      t.timestamps
    end
  end
end
