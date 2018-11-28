class CounterPartiesController < ApplicationController
  def report
    %w[flows sales purchases summary].each do |type|
      send("report_#{type}") and break if params[type]
    end
  end

  private
  def report_flows
    flows     = params[:flows]
    @contract = flows[:contract] ? Contract.find(flows[:contract]) :
                  CounterParty.includes(:contracts).find(params[:id]).main_contract

    sql = <<-SQL
      select 'transaction' as model, t.id, datetime, ifnull(accepted_as_amount, amount) amount, type_id
      from transactions t
      where t.discarded_at is null and contract_id = :contract_id and (datetime between :start_date and :end_date)

      union all

      select 'sale', s.id, datetime, si.total-ifnull(discount,0) as amount, null
      from sales s
      join (
        select sale_id, sum(price*amount) as total from sale_items si group by sale_id
        ) as si on s.id = sale_id
      where s.discarded_at is null and contract_id = :contract_id and (datetime between :start_date and :end_date)

      union all

      select 'purchase', p.id, datetime, pi.total-ifnull(discount,0) as amount, null
      from purchases as p
      join (
        select purchase_id, sum(price*amount) as total from purchase_items pi group by purchase_id
        ) as pi on p.id = purchase_id
      where p.discarded_at is null and contract_id = :contract_id and (datetime between :start_date and :end_date)

      order by datetime
    SQL

    sanitized_sql = ActiveRecord::Base.sanitize_sql [ sql,
      contract_id: @contract.id,
      start_date: flows[:start_date], end_date: Date.strptime(flows[:end_date])+1]
    @records = ActiveRecord::Base.connection.select_all sanitized_sql

    render :report_flows
  end

  def report_summary

  end

  def report_sales
    sale  = params[:sales]
    @contract = sale[:contract] ? Contract.find(sale[:contract]) :
          CounterParty.includes(:contracts).find(params[:id]).main_contract
    @sales = @counter_party.sales.where('datetime between ? and ?',
      sale[:start_date], Date.strptime(sale[:end_date])+1)
    render :report_sales
  end

  def report_purchases
    purchase  = params[:purchases]
    @contract = purchase[:contract] ? Contract.find(purchase[:contract]) :
          CounterParty.includes(:contracts).find(params[:id]).main_contract
    @purchases = @counter_party.purchases.where('datetime between ? and ?',
      purchase[:start_date], Date.strptime(purchase[:end_date])+1)
    render :report_purchases
  end

end
