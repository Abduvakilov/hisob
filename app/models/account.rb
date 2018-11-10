class Account < ApplicationRecord

  def balance(date=Date.today)

    sql = <<-SQL
      select sum( (case
        when type_id/10 = 1 or
          (type_id/10 = 2 and account_id = :id) then -1
        else 1 end ) * amount ) balance
      from transactions t
      where t.discarded_at is null and
        ( account_id = :id or counter_account_id = :id) and
        datetime <= :date
    SQL

    sanitized_sql = ActiveRecord::Base.sanitize_sql [ sql, id: id, date: date]
    ActiveRecord::Base.connection.select_one(sanitized_sql)['balance'] || 0

    # transactions = Transaction.kept.
    #   where('account_id = ? and datetime <= ?', id, date).
    #   group(:type_id)
    # replace_in  = Replace.kept_i.
    #   where('counter_account_id = ? and datetime <= ?', id, date).
    #   sum(:amount)
    # balance = transactions.sum(:amount).reduce(0) do |sum, (key,val)|
    #   unless Income.type_ids.key? key
    #     sum -= val
    #   else
    #     sum += val
    #   end
    #   sum
    # end
    # balance + replace_in
  end

  def self.shown_fields
    %w[ name balance company bank_account_number ]
  end

  def to_s
    "#{name}, #{currency.name}"
  end

  def self.searched_by_child
    'name'
  end

  belongs_to :currency
  belongs_to :company
  has_many   :transactions, -> { kept }

  validates_presence_of :name

end
