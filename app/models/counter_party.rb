#  company_name :string
#  description  :text
#  email        :string
#  is_customer  :boolean
#  is_supplier  :boolean
#  name         :string
#  phone        :string
#  category_id  :integer
#  district_id  :integer
class CounterParty < ApplicationRecord

  def name
    company_name || short_name
  end

  def balance(date=Date.today, contract=contracts.map(&:id))
    transactions_in = Income.kept_i.
      where('datetime <= ?', date).where(contract: contracts).
      joins(:account).group(:contract_id).sum '-amount'
    transactions_out = Expense.kept_i.
      where('datetime <= ?', date).where(contract: contracts).
      joins(:account).group(:contract_id).sum 'amount'
    purchase_items = PurchaseItem.joins(:purchase).
      where(purchases: {discarded_at: nil}).
        where('datetime <= ?', date).where(purchases: {contract: contracts}).
      group(:contract_id).sum '-amount*price'
    sale_items = SaleItem.joins(:sale).
      where(sales: {discarded_at: nil}).
        where('datetime <= ?', date).where(sales: {contract: contracts}).
      group(:contract_id).sum 'amount*price'
    res = [transactions_out, transactions_in, sale_items, purchase_items].
      inject{|memo, el| memo.merge(el){|k, old_v, new_v| old_v + new_v}}
    contract.is_a?(Integer) ? res[contract] : res
  end

  belongs_to :district, optional: true
  belongs_to :category, optional: true
  has_many :sales
  has_many :purchases
  has_many :contracts

  after_create :create_contract

  def create_contract
    Contract.create! counter_party_id: id, name: I18n.t('main_contract'), category_id: 1, currency: Currency.find_by_is_main(true)
  end

  def self.searched_by_childs
  	%w[name company_name]
  end

  def to_s
  	short_name || company_name
  end
end
