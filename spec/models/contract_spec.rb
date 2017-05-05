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

RSpec.describe Contract, type: :model do
  describe '#validations' do
    it 'has a valid factory' do
      expect(build(:contract)).to be_valid
    end
  end
end
