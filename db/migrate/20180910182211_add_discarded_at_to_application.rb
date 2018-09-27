class AddDiscardedAtToApplication < ActiveRecord::Migration[5.2]
  TABLES = %I[accounts currencies product_price_histories departments
              products categories districts salaries companies employees
              counter_parties price_category transactions]
  def self.up
    TABLES.each do |table|
      add_column table, :discarded_at, :datetime
      add_index table, :discarded_at
    end

    remove_column :counter_parties, :is_active
    remove_column :districts, :is_active
    remove_column :products, :is_active

  end

  def self.down
    # TABLES.each do |table|
    #   remove_column table, :discarded_at, :datetime
    # end
  end

end
