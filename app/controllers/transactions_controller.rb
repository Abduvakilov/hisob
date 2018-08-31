class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]

  def index
    super
  #   @transactions = Transaction.where nil
  #   @transactions = @transactions.includes(account: :currency)
  #   @transactions.order(params[:sort] => params[:dir]) if params[:sort].present? && Transaction.permitted_params.include?(params[:sort])
  #   # @transactions = @transactions.filter params
  #   @transactions = @transactions.page( params[:page] ).per OBJECTS_PER_PAGE
  end

  def create
    model = Transaction.models[params[:transaction][:type_id].to_i/10] || Income
    @transaction = model.new(transaction_params)
    if @transaction.save
      flash[:success] = t('views.flash.success.create', model: Transaction.model_name.human)
      if params[:create_and_new]
        redirect_to new_transaction_path(type: @transaction.type)
      else        
        redirect_to transactions_path
      end
    else
      render :new
    end
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to transactions_path, flash: {
        success: t('views.flash.success.update', model: Transaction.model_name.human) }
    else
      render :show
    end
  end
 
  def destroy
    if @transaction.destroy
      redirect_to transactions_path, flash: {
        success: t('views.flash.success.destroy', model: Transaction.model_name.human) }
    end
  end

  def new
    model = Transaction.models[params[:type].to_i]
    @transaction = model.new
  end

  def show
  end

  def filter_fields
    super + [:currency_id, type: []]
  end

  private

  def set_transaction
    @transaction = Transaction.modeled_find(params[:id])
  end

  def transaction_params
    tp = params.require(:transaction).permit Transaction.permitted_params
    tp[:type_id] = tp[:type_id].to_i
    tp[:date] = Date.strptime(tp[:date], '%d.%m.%y').strftime
    return tp
  end
end
