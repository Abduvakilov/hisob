json.extract! account, :id, :name, :company, :currency, :is_bank_account, :bank_account_number, :created_at, :updated_at
json.url account_url(account, format: :json)
