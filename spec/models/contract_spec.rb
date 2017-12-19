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
#  company_id          :integer
#

RSpec.describe Contract, type: :model do
  describe '#validations' do
    it 'has a valid factory' do
      expect(build(:contract)).to be_valid
    end
    it 'should give an error when saving a contract without a customer_request' do
      customer = create(:customer)
      quote = create(:quote)
        customer_request = create(:customer_request)
        company = create(:company)
      contract1 = create(:contract)
      expect(contract1).to be_valid
    end
    it 'should give an error when saving quoteless contract' do
      customer = create(:customer)
        contract1 = create(:contract)
      expect(contract1).to be_valid
    end
  end
end
