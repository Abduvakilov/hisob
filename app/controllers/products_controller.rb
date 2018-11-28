class ProductsController < ApplicationController
  def report
    if params[:flows]
      report_flows
    end
  end

  private
  def report_flows
    flows     = params[:flows]

    sql = <<-SQL
      select 'production' as model, date datetime, sum(amount) total_amount, production_id id
      from production_items
      join productions p on p.id = production_id
      where product_id = :product_id and
            p.discarded_at is null and
            (p.date between :start_date and :end_date)
      group by production_id

      union all
      select 'sale', datetime, sum(amount) total_amount, sale_id id
      from sale_items
      join sales s on s.id = sale_id
      where product_id = :product_id and
            s.discarded_at is null and
            (s.datetime between :start_date and :end_date)
      group by sale_id

      union all
      select 'purchase', datetime, sum(amount) total_amount, purchase_id id
      from purchase_items
      join purchases p on p.id = purchase_id
      where product_id = :product_id and
            p.discarded_at is null and
            (p.datetime between :start_date and :end_date)
      group by purchase_id

      order by datetime
    SQL

    sanitized_sql = ActiveRecord::Base.sanitize_sql [ sql,
      product_id: @product.id,
      start_date: flows[:start_date], end_date: Date.strptime(flows[:end_date])+1]
    @records = ActiveRecord::Base.connection.select_all sanitized_sql

    total_amount_up = 0
    total_amount_down = 0
    @records.each do |rec|
      if rec['model'] == 'sale'
        total_amount_down += rec['total_amount']
      else
        total_amount_up += rec['total_amount']
      end
    end

    render 'report/product/flows', locals: {
      total_amount_up: total_amount_up, total_amount_down: total_amount_down }
  end
end
