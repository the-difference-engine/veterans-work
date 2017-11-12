# == Schema Information
#
# Table name: conversations
#
#  id          :integer          not null, primary key
#  customer_id :integer
#  company_id  :integer
#  quote_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Conversation < ApplicationRecord
  belongs_to :company
  belongs_to :customer
  has_many :messages
end
