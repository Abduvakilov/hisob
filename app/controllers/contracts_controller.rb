class ContractsController < ApplicationController
  prepend_view_path 'app/views/counter_parties'

  def new
    @contract = Contract.new required_key
  end

  def index
    @contracts  = Contract.kept.where required_key
    @contracts.order "#{params[:sort]} #{params[:dir]}" if params[:sort].present? && model.permitted_params.include?(params[:sort])
  end

  def path(object={})
    if object.is_a?(model)
      if object.persisted?
        counter_party_contract_path object
      else
        counter_party_contracts_path object, required_key
      end
    else
      counter_party_contracts_path object.merge(required_key)
    end
  end

  private
  def required_key
    { counter_party_id: params[:counter_party_id] }
  end

end
