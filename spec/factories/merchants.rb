FactoryBot.define do
  factory :merchant, class: User do
    name { Faker::StarWars.character }
  end
end
