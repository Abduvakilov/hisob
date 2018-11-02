class CounterParty < ApplicationRecord

  def name
    company_name || short_name
  end

  def main_contract
    contracts.first
  end

  def balance(date=Date.today, contract_ids=contracts.ids)
    # transactions_in = Income.kept_i.
    #   where('datetime <= ?', date).where(contract: contracts).
    #   joins(:account).group(:contract_id)
    #   # .sum '-ifnull(acceppted_as_amount, amount)'
    # transactions_out = Expense.kept_i.
    #   where('datetime <= ?', date).where(contract: contracts).
    #   joins(:account).group(:contract_id)
    #   # .sum 'ifnull(acceppted_as_amount, amount)'
    # purchase_items = PurchaseItem.joins(:purchase).
    #   where(purchases: {discarded_at: nil}).
    #     where('datetime <= ?', date).where(purchases: {contract: contracts}).
    #   group(:contract_id)
    #   # .sum '-amount*price'
    # sale_items = SaleItem.joins(:sale).
    #   where(sales: {discarded_at: nil}).
    #     where('datetime <= ?', date).where(sales: {contract: contracts}).
    #   group(:contract_id)
    #   # .sum 'amount*price'

    sql = <<-SQL
      select contract_id, sum(amount) balance from (

      select (case type_id/10 when 0 then -1 else 1 end)*ifnull(accepted_as_amount, amount) amount, contract_id from transactions t
      where t.discarded_at is null and contract_id in (:contract_ids) and datetime < :end_date

      union all

      select si.total-discount, contract_id from sales s
      join (
        select sale_id, sum(price*amount) as total from sale_items si group by sale_id
        ) as si on s.id = sale_id
      where s.discarded_at is null and contract_id in (:contract_ids) and datetime < :end_date

      union all

      select pi.total-discount, contract_id from purchases as p
      join (
        select purchase_id, sum(price*amount) as total from purchase_items pi group by purchase_id
        ) as pi on p.id = purchase_id
      where p.discarded_at is null and contract_id in (:contract_ids) and datetime < :end_date

      ) group by contract_id
    SQL

    sanitized_sql = ActiveRecord::Base.sanitize_sql [ sql,
      contract_ids: contract_ids, end_date: date+1]
    res = ActiveRecord::Base.connection.select_all sanitized_sql
    res = res.rows.to_h
    # res = [transactions_out, transactions_in, sale_items, purchase_items].
    #   inject{|memo, el| memo.merge(el){|k, old_v, new_v| old_v + new_v}}
    contract_ids.is_a?(Integer) ? res[contract_ids] : res
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
