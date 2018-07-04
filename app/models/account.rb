class Account < ApplicationRecord
  belongs_to :currency
  belongs_to :company
  has_many   :transactions
  def leftover
    sum = 0
    self.transactions.each do |t| sum += t.amount end
    sum
  end

  def to_s
    self.name + ' (' + self.currency + ')'
  end

end
