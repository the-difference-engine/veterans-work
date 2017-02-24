class ServiceCategory < ApplicationRecord
  has_many :company_services
  has_many :companies, through: :company_services
  has_many :customer_requests
  has_many :customers, through: :customer_requests
end
