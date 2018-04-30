FactoryBot.define do
  factory :merchant, class: User do
    invoice
    credit_card_number { Faker::Number.between(1, 200000) }
    credit_card_expiration_date { Faker::Number.between(1, 100000) }
  end
end
