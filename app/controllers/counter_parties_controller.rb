class CounterPartiesController < ApplicationController
  def report
    if request.post?
      if params[:all_flows?]
        all_flows
      elsif params[:summary?]
        summary
      end
    end

  end

  private
  def all_flows
    all_flows  = params[:all_flows]

    # transaction_sql = Transaction.joins(account: :currency).
    #   kept.where(counter_party: self).
    #   select('"transaction" model, transactions.id, datetime, amount, currencies.name currency_name, currencies.precision currency_precision, type_id')

    # sale_sql = Sale.joins('inner join ('+
    #   SaleItem.select('sale_id, sum(price*amount) total').group(:sale_id).to_sql+
    #   ') si on sale_id = sales.id').joins(:currency).
    #   select('"sale" model, sales.id, datetime, si.total amount, currencies.name currency_name, currencies.precision currency_precision, null type_id')

    # purchase_sql = Purchase.joins('inner join ('+
    #   PurchaseItem.select('purchase_id, sum(price*amount) total').group(:purchase_id).to_sql+
    #   ') pi on purchase_id = purchases.id').joins(:currency).
    #   select('"purchase" model, purchases.id, datetime, pi.total amount, currencies.name currency_name, currencies.precision currency_precision, null type_id')

    sql = <<-SQL
      select 'transaction' as model, t.id, datetime, amount, c.name as currency_name, c.precision as currency_precision, type_id
      from transactions t
      join accounts a on t.account_id = a.id
      join currencies c on a.currency_id = c.id
      where t.discarded_at is null and counter_party_id = :cp_id and (datetime between :start_date and :end_date)

      union all

      select 'sale', s.id, datetime, si.total as amount, c.name, c.precision, null
      from sales s
      join (
        select sale_id, sum(price*amount) as total from sale_items si group by sale_id
        ) as si on s.id = sale_id
      join currencies c on s.currency_id = c.id
      where s.discarded_at is null and counter_party_id = :cp_id and (datetime between :start_date and :end_date)

      union all

      select 'purchase', p.id, datetime, pi.total as amount, c.name, c.precision, null
      from purchases as p
      join (
        select purchase_id, sum(price*amount) as total from purchase_items pi group by purchase_id
        ) as pi on p.id = purchase_id
      join currencies c on p.currency_id = c.id
      where p.discarded_at is null and counter_party_id = :cp_id and (datetime between :start_date and :end_date)

      order by datetime
    SQL

    sanitized_sql = ActiveRecord::Base.sanitize_sql [sql, cp_id: @counter_party.id, start_date: all_flows[:start_date], end_date: all_flows[:end_date]]
    @records = ActiveRecord::Base.connection.select_all sanitized_sql

    render :report_all_flows
  end

  def summary

  end

end
