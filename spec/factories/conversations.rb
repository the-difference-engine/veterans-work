# == Schema Information
#
# Table name: conversations
#
#  id          :integer          not null, primary key
#  customer_id :integer
#  company_id  :integer
#  quote_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :conversation do
    customer_id 1
    company_id 1
    quote_id 1
  end
end
