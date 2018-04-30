FactoryBot.define do
  factory :item do
    name { Faker::StarWars.character }
    description { Faker::Fallout.quote }
    unit_price [123,345,456].sample
    merchant
  end
end
