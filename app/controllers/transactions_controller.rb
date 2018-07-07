class TransactionsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = Transaction.all
  end

	def new_in
    @transaction = Transaction.new
  end

  def create_in
    @transaction = Transaction.new(transaction_params)

    render plain: params
  end

  def create
    render plain: params
    # @transaction = Transaction.new(transaction_params)
    # if @transaction.save
    #   redirect_to @transaction
    # else
    #   render :new
    # end
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction, notice: "Muvaffaqqiyatli saqlandi"
    else
      render :edit
    end
  end
 
  def destroy
    @transaction.destroy
    redirect_to :index
  end

  def show
  end
  def edit
  end


  private

  def set_product
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:notes, :date, :amount, :account, :type)
  end
end
