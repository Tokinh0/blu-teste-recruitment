class Transaction < ApplicationRecord

  belongs_to :store

  validates :transaction_type, :occurrence, :value, :card_number, :document_number, :store_id, presence: :true
  validates :transaction_type,
            :value,
            :occurrence,
            :card_number,
            :document_number,
            :store_id,
            uniqueness: true

  enum transaction_type: {
      debit: 1,
      billet: 2,
      financing: 3,
      credit: 4,
      loan_receipt: 5,
      sell: 6,
      ted_receipt: 7,
      doc_receipt: 8,
      rent: 9
  }

  scope :search_by_store, -> (store_name = nil){
    joins(:store).where("stores.name LIKE ?", "%#{store_name}%") unless store_name.blank?
  }

  scope :search_by_cpf, -> (document_number = nil){
    where(document_number: document_number) unless document_number.blank?
  }

end
