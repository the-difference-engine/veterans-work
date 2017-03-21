# == Schema Information
#
# Table name: service_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :service_category do
    sequence(:name) { |n| "category_#{n}" }
  end
end
