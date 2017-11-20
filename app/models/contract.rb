# == Schema Information
#
# Table name: contracts
#
#  id                  :integer          not null, primary key
#  quote_id            :integer
#  customer_request_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  completion_date     :date
#  view_date           :date
#

class Contract < ApplicationRecord
  belongs_to :quote
  belongs_to :customer_request
  belongs_to :customer
  belongs_to :company
end
