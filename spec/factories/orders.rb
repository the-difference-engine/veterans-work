# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  company_id :integer
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  total      :decimal(6, 2)
#

FactoryGirl.define do
  factory :order do
    company
    quantity 1
    total 5.00
  end
end
