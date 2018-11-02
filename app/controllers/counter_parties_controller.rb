class CounterPartiesController < ApplicationController
  def report
    if request.post?
      if params[:all_flows?]
        all_flows_report
      elsif params[:summary?]
        summary_report
      end
    end

  end

  private
  def all_flows_report
    all_flows   = params[:all_flows]
    @contract   = Contract.find(all_flows[:contract]) ||
                  CounterParty.includes(:contracts).find(params[:id]).main_contract

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
      select 'transaction' as model, t.id, datetime, ifnull(accepted_as_amount, amount) amount, type_id
      from transactions t
      where t.discarded_at is null and contract_id = :contract_id and (datetime between :start_date and :end_date)

      union all

      select 'sale', s.id, datetime, si.total-discount as amount, null
      from sales s
      join (
        select sale_id, sum(price*amount) as total from sale_items si group by sale_id
        ) as si on s.id = sale_id
      where s.discarded_at is null and contract_id = :contract_id and (datetime between :start_date and :end_date)

      union all

      select 'purchase', p.id, datetime, pi.total-discount as amount, null
      from purchases as p
      join (
        select purchase_id, sum(price*amount) as total from purchase_items pi group by purchase_id
        ) as pi on p.id = purchase_id
      where p.discarded_at is null and contract_id = :contract_id and (datetime between :start_date and :end_date)

      order by datetime
    SQL

    sanitized_sql = ActiveRecord::Base.sanitize_sql [ sql,
      contract_id: @contract.id, start_date: all_flows[:start_date], end_date: Date.strptime(all_flows[:end_date])+1]
    @records = ActiveRecord::Base.connection.select_all sanitized_sql

    render :report_all_flows
  end

  def summary_report

  end

end
