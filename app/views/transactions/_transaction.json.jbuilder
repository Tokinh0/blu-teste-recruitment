json.extract! transaction, :id, :transaction_type, :occurrence, :value, :card_number, :document_number, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
