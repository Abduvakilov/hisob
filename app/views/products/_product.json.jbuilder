json.extract! product, :id, :name
if params[:contract_id]
  json.contract do
    contract = Contract.find(params[:contract_id])
    json.id contract.id
    json.name contract.to_s
    json.last_price product.price(contract_id: params[:contract_id])
    json.currency contract.currency.to_s
  end
end
# json.path product_path(product, format: :json)
