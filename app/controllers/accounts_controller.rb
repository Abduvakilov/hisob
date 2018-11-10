class AccountsController < ApplicationController
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
    all_flows     = params[:all_flows]
    @account      = Account.includes(:currency).find(params[:id])
    @transactions = Transaction.kept.
      where('account_id = :id or counter_account_id = :id', id: params[:id]).
      where('datetime between ? and ?',
        all_flows[:start_date], all_flows[:end_date])
    render :report_all_flows
  end

  def summary_report

  end
end
