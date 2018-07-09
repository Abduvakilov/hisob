class CounterPartiesController < ApplicationController
  before_action :set_counter_party, only: [:show, :edit, :update, :destroy]

  def new
    @counter_party = CounterParty.new
  end

  def create
    @counter_party = CounterParty.new(counter_party_params)
    if @counter_party.save
      render plain: params
    else
      render :new
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_counter_party
    @counter_party = Product.find(params[:district_id, :category_id, :name, :company_name, :phone, :email,
                                         :is_supplier, :is_cutomer, :is_active, :description])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def counter_party_params
    params.require(:counter_party).permit(:name, :company_id)
  end

end
