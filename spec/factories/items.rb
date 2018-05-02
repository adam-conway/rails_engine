FactoryBot.define do
  factory :item do
    name { Faker::StarWars.character }
    description { Faker::Fallout.quote }
    unit_price [123,345,456].sample
    merchant
    created_at "2018-04-30 10:45:00 UTC"
    updated_at "2018-04-31 10:45:00 UTC"
  end
end
