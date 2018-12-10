class TransactionsController < ApplicationController

  def index
    self.objects  = model.kept.ordered.search(params[:search]).page(params[:page]).per(rows_per_page)
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
        head :created, location: new_transaction_path(type: @transaction.type)
      else
        head :created, location: transactions_path
      end
    else
      render :new, layout: false
    end
  end

  def update
    type = (Transaction::ALL_TYPES.keys.map(&:to_s) & params.keys)[0]
    if @transaction.update(transaction_params(type))
      flash[:success] = t('views.flash.success.update', model: Transaction.model_name.human)
      head :ok, location: transactions_path
    else
      render :show, layout: false
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

  def set_object
    @transaction = Transaction.modeled_find(params[:id])
  end

  def transaction_params(type)
    tp = params.require(type).permit Transaction.permitted_params
    tp[:type_id] = tp[:type_id].to_i
    return tp
  end
end
