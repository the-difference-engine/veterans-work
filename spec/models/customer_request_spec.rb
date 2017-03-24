# == Schema Information
#
# Table name: customer_requests
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  address             :string
#  city                :string
#  state               :string
#  zipcode             :string
#  service_category_id :integer
#  description         :text
#  customer_id         :integer
#  expires_date        :date
#  latitude            :float
#  longitude           :float
#
# Indexes
#
#  index_customer_requests_on_expires_date  (expires_date)
#

require 'rails_helper'

RSpec.describe CustomerRequest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
