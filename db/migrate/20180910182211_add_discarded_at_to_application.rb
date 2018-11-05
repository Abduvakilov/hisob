class AddDiscardedAtToApplication < ActiveRecord::Migration[5.2]
  TABLES = %I[accounts currencies prices departments
              products categories districts salaries companies employees
              counter_parties transactions]
  def self.up
    TABLES.each do |table|
      add_column table, :discarded_at, :datetime
      add_index table, :discarded_at
    end
  end

  def self.down
    TABLES.each do |table|
      remove_column table, :discarded_at, :datetime
    end
  end

end
