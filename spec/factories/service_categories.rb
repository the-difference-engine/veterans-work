FactoryGirl.define do
  factory :service_category do
    sequence(:name) { |n| "category_#{n}" }
  end
end
