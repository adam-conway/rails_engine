FactoryBot.define do
  factory :item, class: User do
    name { Faker::StarWars.character }
    description { Faker::Fallout.quote }
    unit_price [123,345,456].sample
    merchant 
  end
end
