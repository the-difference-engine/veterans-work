# == Schema Information
#
# Table name: credits
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :credit do
    cost "9.99"
    order_id 1
    quote_id 1
  end
end
