FactoryGirl.define do
  factory :company do
    sequence(:email) {|n| "horatio_gomez#{n}@mailmail.com" }
    password "12345678"
  end
end
