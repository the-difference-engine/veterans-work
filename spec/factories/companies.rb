FactoryGirl.define do
  factory :company do
    sequence(:email) {|n| "horatio_gomez#{n}@mailmail.com" }
    password "12345678"
    name "Bob"
    zip_code "12345"
    phone "8479451000"
    description "text goes here"
    url  "http:" 
  end
end
