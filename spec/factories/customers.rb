FactoryBot.define do
  factory :customer, class: User do
    first_name { Faker::StarWars.character }
    last_name { Faker::StarWars.character }
  end
end
