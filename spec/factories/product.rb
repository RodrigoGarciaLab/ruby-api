FactoryGirl.define do
  factory :product do
    name { Faker::Name.name }
    price 5
  end
end