10.times do
  rand_number = rand.to_s[2].to_i
  while rand_number == 0
    rand_number = rand.to_s[2].to_i
  end
  Transaction.create(
      transaction_type: Transaction.transaction_types.key(rand_number),
      occurrence: rand(1.years).seconds.ago,
      value: 1000.0-500.0 * rand() + 500,
      card_number: "#{rand.to_s[2..5]}#{rand.to_s[2..5]}#{rand.to_s[2..5]}#{rand.to_s[2..5]}",
      document_number: rand.to_s[2..12],
      store: Store.create(
          name: "Loja nº#{rand.to_s[2..3]}",
          shopkeeper: Shopkeeper.create(
              name: "shopkeeper nº#{rand.to_s[2..3]}"
          )
      )
  )
end
