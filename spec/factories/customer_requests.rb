FactoryGirl.define do
  factory :customer_request do
    sequence(:customer_id) { |n| n }
    address Faker::Address.street_address
    city Faker::Address.city
    state Faker::Address.state_abbr
    zipcode Faker::Address.zip_code
    service_category
    description Faker::Lorem.paragraph
    expires_date Date.today() + 3
  end
end
