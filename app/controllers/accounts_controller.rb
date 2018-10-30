class AccountsController < ApplicationController
  def report
    if request.post?
      all_flows = params.require(:all_flows)
    end
  end
end
