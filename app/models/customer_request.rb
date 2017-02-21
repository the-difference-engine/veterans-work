class CustomerRequest < ApplicationRecord
  has_one :service_category
  belongs_to :customer
end
