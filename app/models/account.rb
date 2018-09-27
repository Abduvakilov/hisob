#  bank_account_number :integer
#  is_bank_account     :boolean
#  name                :string
#  company_id          :integer
#  currency_id         :integer
class Account < ApplicationRecord

  def leftover
    transactions = Transaction.kept.where(account: self).group(:type_id)
    replace_in  = Replace.kept.all_i.where(counter_account: self).sum :amount
    balance = transactions.sum(:amount).reduce(0) do |sum, (key,val)|
      if Income.type_ids.key? key
        sum += val
      elsif Expense.type_ids.key?(key) || Replace.type_ids.key?(key)
        sum -= val
      end
      sum
    end
    balance + replace_in
  end


  def to_s
    "#{self.name}, #{self.currency.name}"
  end

  def self.searched_by_child
    'name'
  end

  belongs_to :currency
  belongs_to :company
  has_many   :transactions

  validates_presence_of :name

end
