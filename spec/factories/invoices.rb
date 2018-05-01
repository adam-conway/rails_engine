FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status ["Failed", "Success"].sample
    created_at "2018-04-30 10:45:00 UTC"
    updated_at "2018-04-31 10:45:00 UTC"
  end
end
