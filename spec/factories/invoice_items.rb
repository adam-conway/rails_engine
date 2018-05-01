FactoryBot.define do
  factory :invoice_item do
    quantity [12, 123, 1234].sample
    price [234, 345, 678].sample
    item
    invoice
    created_at "2018-04-30 10:45:00 UTC"
    updated_at "2018-04-31 10:45:00 UTC"
  end
end
