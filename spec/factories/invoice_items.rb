FactoryBot.define do
  factory :invoice_item do
    quantity [12, 123, 1234].sample
    price [234, 345, 678].sample
    item
    invoice
  end
end
