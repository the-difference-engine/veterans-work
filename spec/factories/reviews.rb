FactoryGirl.define do
  factory :review do
    customer
    company
    stars { rand(1..5) }
    body Faker::Lorem.paragraph
  end
end
