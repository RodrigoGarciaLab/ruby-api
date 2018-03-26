FactoryGirl.define do
  factory :order do
    created_by { Faker::Number.number(10) }
  end
end