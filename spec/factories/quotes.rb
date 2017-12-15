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
#  accepted                 :boolean
#  customer_viewed          :boolean          default(FALSE)
#  view_date                :date
#

FactoryGirl.define do
  factory :quote do
    customer_request
    company
    materials_cost_estimate 100.00
    labor_cost_estimate 100.00
    start_date Date.today()
    completion_date_estimate Date.today() + 3
    notes "MyText"
    accepted nil
  end

  trait :blank_costs do
    materials_cost_estimate ''
    labor_cost_estimate nil
  end
end
