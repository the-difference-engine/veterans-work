# == Schema Information
#
# Table name: quotes
#
#  id                       :integer          not null, primary key
#  customer_request_id      :integer
#  company_id               :integer
#  materials_cost_estimate  :decimal(, )
#  labor_cost_estimate      :decimal(, )
#  start_date               :date
#  completion_date_estimate :date
#  notes                    :text
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

FactoryGirl.define do
  factory :quote do
    customer
    company
    materials_cost_estimate "9.99"
    labor_cost_estimate "9.99"
    start_date "MyString"
    completion_date_estimate "MyString"
    materials "MyText"
    notes "MyText"
  end
end
