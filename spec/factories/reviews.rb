FactoryGirl.define do
  factory :review do
    customer
    company
    stars [1..5].sample
    body Faker::Lorem.paragraph
  end
end
