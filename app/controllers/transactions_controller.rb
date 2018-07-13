class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @transactions_grid = TransactionsGrid.new(params[:Transaction_grid]) do |scope|
      scope.page(params[:page])
    end
  end

  def show

  end

	def new_in
    @transaction = Transaction.new
  end

  def create
    require 'date'
    params[:date] = Date.strptime params[:date], '%d.%m.%Y'
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      flash[:success] = "Aylanma saqlanib qo'yildi"
      if params[:create_and_new]
        @transaction = Transaction.new
        render :new_in
      else        
        redirect_to transactions_path
      end
    else
      render :new_in
    end
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
    params.require(:transaction).permit(:notes, :date, :amount, :account_id, :in_out_type)
  end
end
