class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update, :destroy]

  def index
    self.objects  = model.kept.ordered.search(params[:search]).page(params[:page]).per OBJECTS_PER_PAGE
    self.objects.order_values.prepend "#{params[:sort]} #{params[:dir]}" if params[:sort].present? && model.permitted_params.include?(params[:sort])
    filter_params = params.permit filter_fields
    @sorted       = filter_params.present?
    self.objects  = objects.filter_with(filter_params).includes(model.belongs) # TODO include shown fields of belongs
  end

  def create
    type = (Transaction::ALL_TYPES.keys.map(&:to_s) & params.keys)[0]
    model = type.to_s.classify.constantize
    @transaction = model.new(transaction_params(type))
    if @transaction.save
      flash[:success] = t('views.flash.success.create', model: Transaction.model_name.human)
      if params[:create_and_new]
        redirect_to new_transaction_path(type: @transaction.type)
      else
        redirect_to transactions_path
      end
    else
      puts self.object.errors.inspect # For debugging
      render :new
    end
  end

  def update
    type = (Transaction::ALL_TYPES.keys.map(&:to_s) & params.keys)[0]
    if @transaction.update(transaction_params(type))
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

  def transaction_params(type)
    tp = params.require(type).permit Transaction.permitted_params
    tp[:type_id] = tp[:type_id].to_i
    return tp
  end
end
