# == Schema Information
#
# Table name: service_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ServiceCategory < ApplicationRecord
  has_many :company_services
  has_many :companies, through: :company_services
  has_many :customer_requests
  has_many :customers, through: :customer_requests
end
