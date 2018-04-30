FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status ["Failed", "Success"].sample
  end
end
