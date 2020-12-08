class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :transaction_type
      t.datetime :occurrence
      t.decimal :value
      t.string :card_number
      t.string :document_number
      t.uuid :store_id

      t.timestamps
    end
  end
end
