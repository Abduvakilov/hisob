# == Schema Information
#
# Table name: accounts
#
#  id                  :integer          not null, primary key
#  bank_account_number :integer
#  is_bank_account     :boolean
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  company_id          :integer
#  currency_id         :integer
#
# Indexes
#
#  index_accounts_on_company_id   (company_id)
#  index_accounts_on_currency_id  (currency_id)
#

class Account < ApplicationRecord

  def leftover
    sum = ActionController::Base.helpers.number_with_precision self.transactions.sum(:amount), precision: 0, delimiter: ' '
    "#{sum} #{self.currency.name}"
  end

  def to_s
    self.name + ' (' + self.currency + ')'
  end

  def self.searched_by_childs
    'name'
  end

  belongs_to :currency
  belongs_to :company
  has_many   :transactions

  validates_presence_of :name

end
