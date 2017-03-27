# == Schema Information
#
# Table name: contracts
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  quote_id            :string
#  customer_request_id :string
#

class Contract < ApplicationRecord
  belongs_to :quote
  belongs_to :customer_request
end
