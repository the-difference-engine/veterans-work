# == Schema Information
#
# Table name: reviews
#
#  id          :integer          not null, primary key
#  customer_id :integer
#  company_id  :integer
#  stars       :integer
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :review do
    customer
    company
    stars { rand(1..5) }
    body Faker::Lorem.paragraph
  end
end
