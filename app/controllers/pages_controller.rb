class PagesController < ActionController::Base
	layout 'application'
  before_action :authenticate_user!

  def index
    @accounts = Account.all
  end

end
