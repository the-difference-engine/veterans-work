class CustomerRequest < ApplicationRecord
  belongs_to :service_category
  belongs_to :customer
end
