class AddUniqueIndexToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_index :transactions,
              [:transaction_type, :value, :occurrence, :card_number, :document_number, :store_id],
              unique: true,
              name: 'index_transactions_on_fields'
  end
end
