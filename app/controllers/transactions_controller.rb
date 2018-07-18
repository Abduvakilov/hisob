class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_new_transaction, only: [:new_in, :new_out, :new_in_out]

  def index
    @transactions = Transaction.page params[:page]
  end

  def create
    require 'date'
    if params[:date] 
      params[:date] = Date.strptime params[:date], '%d.%m.%Y'
    end
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      flash[:success] = "Aylanma saqlanib qo'yildi"
      if params[:create_and_new]
        redirect_to :back
      else        
        redirect_to transactions_path
      end
    else
      render :back
    end
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction, flush: { success: "Aylanma muvaffaqqiyatli tahrirlandi" }
    else
      render :edit
    end
  end
 
  def destroy
    @transaction.destroy
    redirect_to :index
  end

  def edit
  end

  def show
  end

  def new_in
  end

  def new_out
  end

  def new_in_out
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_new_transaction
    @transaction = Income.new
  end

  def transaction_params
    params.require(:transaction).permit(:notes, :date, :amount, :account_id, :in_out_type)
  end
end
