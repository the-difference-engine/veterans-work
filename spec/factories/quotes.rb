FactoryGirl.define do
  factory :quote do
    customer_id 1
    company_id 1
    materials_cost_estimate "9.99"
    labor_cost_estimate "9.99"
    start_date "MyString"
    completion_date_estimate "MyString"
    materials "MyText"
    notes "MyText"
  end
end
