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
#

RSpec.describe Contract, type: :model do
  describe '#validations' do
    it 'has a valid factory' do
      expect(build(:contract)).to be_valid
    end
  end
  describe User do
    describe '#ids' do
      it { is_expected.to validate_presence_of(:quote_id) }
      it { is_expected.to validate_presence_of(:customer_request_id) }
    end
  end
end