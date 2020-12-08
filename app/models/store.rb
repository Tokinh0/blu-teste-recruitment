class Store < ApplicationRecord
  belongs_to :shopkeeper
  has_many :transactions
end
