# == Schema Information
#
# Table name: customers
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#
# Indexes
#
#  index_customers_on_confirmation_token    (confirmation_token) UNIQUE
#  index_customers_on_email                 (email) UNIQUE
#  index_customers_on_reset_password_token  (reset_password_token) UNIQUE
#

RSpec.describe Customer, type: :model do
  describe '#validations' do
    it 'has a valid factory' do
      expect(build(:customer)).to be_valid
    end
  end

  describe 'open quotes' do
    it 'returns only open quotes' do
      customer = create(:customer)
      company = create(:company)
      customer_request1 = create(:customer_request,
        customer_id: customer.id
        )
      customer_request2 = create(:customer_request,
        customer_id: customer.id
        )
      quote1 = create(:quote,
        customer_request_id: customer_request1.id,
        company_id: company.id
      )
      create(:quote,
        customer_request_id: customer_request2.id,
        company_id: company.id,
        accepted: true
      )
      expect(customer.open_quotes).to eq([quote1])
    end

    it 'should not return accepted quotes' do
      customer = create(:customer)
      company = create(:company)
      customer_request2 = create(:customer_request,
        customer_id: customer.id
        )
      quote2 = create(:quote,
        customer_request_id: customer_request2.id,
        company_id: company.id,
        accepted: true
      )
      expect(customer.open_quotes).not_to include(quote2)
    end
  end

  describe 'accepted_quotes' do
    it 'should not return anything but accepted quotes' do
      customer = create(:customer)
      company = create(:company)
      customer_request1 = create(:customer_request,
        customer_id: customer.id
        )
      customer_request2 = create(:customer_request,
        customer_id: customer.id
        )
      create(:quote,
        customer_request_id: customer_request1.id,
        company_id: company.id
      )
      quote2 = create(:quote,
        customer_request_id: customer_request2.id,
        company_id: company.id,
        accepted: true
      )
      expect(customer.accepted_quotes).to eq([quote2])
    end

    it 'should return accepted quotes' do
      customer = create(:customer)
      company = create(:company)
      customer_request1 = create(:customer_request,
        customer_id: customer.id
        )
      quote1 = create(:quote,
        customer_request_id: customer_request1.id,
        company_id: company.id,
        accepted: nil
      )
      expect(customer.accepted_quotes).not_to include(quote1)
    end
  end 
end
