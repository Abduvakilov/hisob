class CounterPartiesController < ApplicationController
  def report
    if params[:flows]
      report_flows
    elsif params[:summary]
      report_summary
    end
  end

  private
  def report_flows
    flows     = params[:flows]
    if flows[:start_date].empty? || flows[:end_date].empty?
      redirect_to new_report_counter_party_path(
        'flows_start_date]': flows[:start_date].present?, 'flows_end_date': flows[:end_date].present?)
      return
    end
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

end
