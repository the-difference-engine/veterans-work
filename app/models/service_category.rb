class ServiceCategory < ApplicationRecord
  has_many :company_services
  has_many :companies, through: :company_services
end
