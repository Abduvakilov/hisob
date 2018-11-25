class CreatePayrolls < ActiveRecord::Migration[5.2]
  def change
    create_table :payrolls do |t|
      t.integer :month, index: true
      t.integer :year, index: true
      t.text    :notes

      t.datetime :discarded_at, index: true
      t.timestamps
    end

    create_table :payroll_items do |t|
      t.references :payroll, foreign_key: true, index: true
      t.references :employee, foreign_key: true
      (1..31).each do |day_number|
        t.float "day_#{day_number}_hours"
      end
      t.float :non_chash
      t.float :tax
      t.float :bonus
      t.float :overtime

      t.timestamps
    end
  end
end
