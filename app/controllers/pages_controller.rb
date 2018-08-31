class PagesController < ActionController::Base
	layout 'application'

  def index
    @accounts = Account.all
  end

end
