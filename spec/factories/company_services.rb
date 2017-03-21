# == Schema Information
#
# Table name: company_services
#
#  id                  :integer          not null, primary key
#  company_id          :integer
#  service_category_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :company_service do
    company
    service_category
  end
end
