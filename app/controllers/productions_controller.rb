class ProductionsController < ApplicationController

  private
  def model_params
    sp = params.require(:production).permit Production.permitted_params
    sp[:date] = Date.strptime(sp[:date], '%d.%m.%y').strftime rescue sp[:date]
    return sp
  end

end
