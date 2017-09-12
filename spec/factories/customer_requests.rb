# == Schema Information
#
# Table name: customer_requests
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  address             :string
#  city                :string
#  state               :string
#  zipcode             :string
#  service_category_id :integer
#  description         :text
#  customer_id         :integer
#  expires_date        :date
#  latitude            :float
#  longitude           :float
#
# Indexes
#
#  index_customer_requests_on_expires_date  (expires_date)
#

FactoryGirl.define do
  factory :customer_request do
    customer
    address '301 N Michigan Ave'
    city 'Chicago'
    state 'IL'
    zipcode '60601'
    service_category
    description Faker::Lorem.paragraph
    expires_date Date.today() + 3
  end
end
