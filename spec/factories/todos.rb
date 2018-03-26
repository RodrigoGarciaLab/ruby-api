FactoryGirl.define do
  factory :todos do
    created_by { Faker::Number.number(10) }
  end
end