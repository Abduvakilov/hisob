class PurchasesController < ApplicationController

  private
  def model_params
    pp = params.require(:purchase).permit Purchase.permitted_params
    pp[:date] = Date.strptime(pp[:date], '%d.%m.%y').strftime rescue pp[:date]
    return pp
  end

end
