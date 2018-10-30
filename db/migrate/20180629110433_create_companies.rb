class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :short_name
      t.string :long_name
      t.timestamps
    end
  end
end
