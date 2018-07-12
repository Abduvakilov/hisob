class Account < ApplicationRecord
  belongs_to :currency
  belongs_to :company
  has_many   :transactions

  def leftover
    sum = ActionController::Base.helpers.number_with_precision self.transactions.sum(:amount), precision: 0, delimiter: ' '
    "#{sum} #{self.currency.name}"
  end

  def to_s
    self.name + ' (' + self.currency + ')'
  end

end
