class CounterParty < ApplicationRecord

  def name
    company_name || short_name
  end

  def main_contract
    contracts.find_by('due_date >= ? or due_date is null', Date.today)
  end

  def balance(date=Date.tomorrow, contract_ids=contracts.ids) # start of the date
    sql = <<-SQL
      select contract_id, sum(amount) balance from (

      select (case type_id/10 when 0 then -1 else 1 end)*ifnull(accepted_as_amount, amount) amount, contract_id from transactions t
      where t.discarded_at is null and contract_id in (:contract_ids) and datetime <= :end_date

      union all

      select si.total-ifnull(discount,0), contract_id from sales s
      join (
        select sale_id, sum(price*amount) as total from sale_items si group by sale_id
        ) as si on s.id = sale_id
      where s.discarded_at is null and contract_id in (:contract_ids) and datetime <= :end_date

      union all

      select pi.total-ifnull(discount,0), contract_id from purchases as p
      join (
        select purchase_id, sum(price*amount) as total from purchase_items pi group by purchase_id
        ) as pi on p.id = purchase_id
      where p.discarded_at is null and contract_id in (:contract_ids) and datetime <= :end_date

      ) as contract_balance group by contract_id
    SQL

    sanitized_sql = ActiveRecord::Base.sanitize_sql [ sql,
      contract_ids: contract_ids, end_date: date]
    res = ActiveRecord::Base.connection.select_all sanitized_sql
    res = res.rows.to_h
    contract_ids.is_a?(Integer) ? res[contract_ids] : res
  end

  validates_presence_of :short_name, unless: :company_name?
  validates_presence_of :company_name, unless: :short_name?

  belongs_to :district, optional: true
  belongs_to :category, optional: true
  has_many :contracts, -> { kept }
  has_many :sales,     -> { kept }, through: :contracts
  has_many :purchases, -> { kept }, through: :contracts

  after_create :create_contract

  def create_contract
    Contract.create! counter_party_id: id, name: I18n.t('main_contract'), category_id: Category.main_price_type, currency: Currency.find_by_is_main(true)
  end

  def self.searched_by_childs
  	%w[name company_name]
  end

  def to_s
  	short_name || company_name
  end
end
