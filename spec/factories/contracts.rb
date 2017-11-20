# == Schema Information
#
# Table name: contracts
#
#  id                  :integer          not null, primary key
#  quote_id            :integer
#  customer_request_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  completion_date     :date
#  view_date           :date
#

FactoryGirl.define do
  factory :contract do
    quote
    customer_request
    completion_date Date.new
  end
end
