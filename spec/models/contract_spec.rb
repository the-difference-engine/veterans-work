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

require 'rails_helper'

RSpec.describe Contract, type: :model do

end
