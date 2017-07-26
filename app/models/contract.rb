# == Schema Information
#
# Table name: contracts
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  quote_id            :string
#  customer_request_id :string
#  completion_date     :date
#

class Contract < ApplicationRecord
  belongs_to :quote
  belongs_to :customer_request
  belongs_to :customer
  belongs_to :company
end
