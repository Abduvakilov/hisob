json.id counter_party.id
json.contracts counter_party.contracts.in_date(params[:date]) do  |contract|
  json.id contract.id
  json.name contract.to_s
end
json.path counter_party_path(counter_party, format: :json)
