class AccountsController < ApplicationController
  def report
    if params[:flows]
      report_flows
    elsif params[:summary]
      report_summary
    end
  end

  private
  def report_flows
    start_date = Date.strptime params[:flows][:start_date]
    end_date   = Date.strptime params[:flows][:end_date]

    @transactions = Transaction.kept
      .where('account_id = :id or counter_account_id = :id', id: params[:id])
      .where(datetime: start_date..(end_date+1))

    total_amount_up = 0
    total_amount_down = 0

    @transactions.each do |transaction|
      if transaction.income? || transaction.counter_account == @account
        total_amount_up += transaction.amount
      else
        total_amount_down += transaction.amount
      end
    end

    render 'report/account/flows', locals: {
      start_date: start_date, end_date: end_date,
      total_amount_up: total_amount_up, total_amount_down: total_amount_down,
      closing: @account.balance(start_date), last_balance: @account.balance(end_date+1),
      currency: @account.currency }
  end

  def report_summary

  end
end
