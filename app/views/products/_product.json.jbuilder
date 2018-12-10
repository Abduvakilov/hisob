json.extract! product, :id, :name
if params[:contract_id]
  json.contract do
    contract = Contract.find(params[:contract_id])
    json.id contract.id
    json.name contract.name
    json.last_price product.price_for_contract(params[:contract_id]).for_unit
    json.currency contract.currency.to_s
  end
end
# json.path product_path(product, format: :json)
