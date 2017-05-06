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

RSpec.describe CustomerRequest, type: :model do
  describe '#validations' do
    it 'has a valid factory' do
      expect(build(:customer_request)).to be_valid
    end
  end

  describe '#open quotes' do
    it 'returns quotes that have nil for :accepted' do
      customer_request = create(:customer_request)
      quote1 = create(:quote,
        accepted: false,
        customer_request_id: customer_request.id
      )
      quote2 = create(:quote,
        accepted: true,
        customer_request_id: customer_request.id
      )
      quote3 = create(:quote,
        customer_request_id: customer_request.id
      )
      expect(customer_request.open_quotes).to eq([quote3])
    end
  end

  describe '#accepted quotes' do
    it 'returns quotes that have true for :accepted' do
      customer_request = create(:customer_request)
      quote1 = create(:quote,
        accepted: false,
        customer_request_id: customer_request.id
      )
      quote2 = create(:quote,
        accepted: true,
        customer_request_id: customer_request.id
      )
      quote3 = create(:quote,
        customer_request_id: customer_request.id
      )
      expect(customer_request.accepted_quotes).to eq([quote2])
    end
  end
end
