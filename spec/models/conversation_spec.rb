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

require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe "validations" do 
    it 'has a valid factory' do 
      expect(build(:conversation)).to be_valid
    end
  end
end

