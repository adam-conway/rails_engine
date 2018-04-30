FactoryBot.define do
  factory :invoice, class: User do
    customer
    merchant
    status ["Failed", "Success"].sample
  end
end
