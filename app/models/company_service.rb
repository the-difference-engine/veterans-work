class CompanyService < ApplicationRecord
  belongs_to :company
  belongs_to :service_category
end
