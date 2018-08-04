class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_new_transaction, only: [:new_in, :new_out, :new_inout]

  def index
    @transactions = Transaction.search(params[:search])
      .page( params[:page] ).per 10
    if params.key? :sort
      @transactions.order_values.prepend "#{params[:sort]} #{params[:dir]}"
    end
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      flash[:success] = t('views.flash.success.create', model: Transaction.model_name.human)
      if params[:create_and_new]
        redirect_back fallback_location: transactions_path
      else        
        redirect_to transactions_path
      end
    else
      render Rails.application.routes.recognize_path(request.referer)[:action]
    end
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to transactions_path, flash: { success: t('views.flash.success.update', model: Transaction.model_name.human) }
    else
      render :edit
    end
  end
 
  def destroy
    if @transaction.destroy
      redirect_to transactions_path, flash: { success: t('views.flash.success.destroy', model: Transaction.model_name.human) }
    end
  end

  def edit
  end

  def show
  end

  def new_in
  end

  def new_out
  end

  def new_inout
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_new_transaction
    @transaction = Transaction.new
  end

  def transaction_params
    require 'date'
    tp = params.require(:transaction).permit Transaction.permitted_params
    tp[:type_id] = tp[:type_id].to_i
    tp[:date] = Date.strptime(tp[:date], '%d.%m.%y').strftime
    return tp
  end
end
