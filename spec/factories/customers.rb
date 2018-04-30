FactoryBot.define do
  factory :customer do
    first_name { Faker::StarWars.character }
    last_name { Faker::StarWars.character }
  end
end
