# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  company_id :integer
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :order do
    company_id 1
    quantity 1
  end
end
