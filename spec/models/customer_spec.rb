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

  describe 'open_quotes' do
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
    it 'should return accepted quotes' do
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
        company_id: company.id,
        accepted: nil
      )
      quote2 = create(:quote,
        customer_request_id: customer_request2.id,
        company_id: company.id,
        accepted: true
      )
      contract = create(:contract,
        quote_id: quote2.id,
        customer_request_id: customer_request2.id,
        completion_date: nil)
      expect(customer.accepted_quotes).to eq([quote2])
    end

    it 'should not return quotes that have not been accepted' do
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
        company_id: company.id,
        accepted: nil
      )
      quote2 = create(:quote,
        customer_request_id: customer_request2.id,
        company_id: company.id,
        accepted: true
      )
      contract = create(:contract,
        quote_id: quote2.id,
        customer_request_id: customer_request2.id,
        completion_date: nil)
      expect(customer.accepted_quotes).not_to include(quote1)
    end

    it 'should not return completed quotes' do
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
        company_id: company.id,
        accepted: nil
      )
      quote2 = create(:quote,
        customer_request_id: customer_request2.id,
        company_id: company.id,
        accepted: true
      )
      contract = create(:contract,
        quote_id: quote2.id,
        customer_request_id: customer_request2.id,
        completion_date: nil)
      contract.update(completion_date: 1.day.ago)
      expect(customer.accepted_quotes).not_to include(quote2)
    end
  end 

  describe 'declined_quotes' do
    it 'should return declined quotes' do
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
        company_id: company.id,
        accepted: nil
      )
      quote2 = create(:quote,
        customer_request_id: customer_request2.id,
        company_id: company.id,
        accepted: true
      )
      contract = create(:contract,
        quote_id: quote2.id,
        customer_request_id: customer_request2.id,
        completion_date: nil)
      quote1.update(accepted: false)
      expect(customer.declined_quotes).to include(quote1)
    end

    it 'should not return accepted quotes' do
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
        company_id: company.id,
        accepted: nil
      )
      quote2 = create(:quote,
        customer_request_id: customer_request2.id,
        company_id: company.id,
        accepted: true
      )
      contract = create(:contract,
        quote_id: quote2.id,
        customer_request_id: customer_request2.id,
        completion_date: nil)
      quote1.update(accepted: false)
      expect(customer.declined_quotes).not_to include(quote2)
    end

    it 'should not return open quotes' do
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
        company_id: company.id,
        accepted: nil
      )
      quote2 = create(:quote,
        customer_request_id: customer_request2.id,
        company_id: company.id,
        accepted: true
      )
      expect(customer.declined_quotes).not_to include(quote1)
    end    
  end

  describe 'completed_quotes' do
    it 'should return completed quotes' do
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
        company_id: company.id,
        accepted: nil
      )
      quote2 = create(:quote,
        customer_request_id: customer_request2.id,
        company_id: company.id,
        accepted: true
      )
      contract = create(:contract,
        quote_id: quote2.id,
        customer_request_id: customer_request2.id,
        completion_date: nil)
      contract.update(completion_date: 1.day.ago)
      expect(customer.completed_quotes).to include(quote2)
    end 

    it 'should not return accepted quotes that have not been completed' do
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
        company_id: company.id,
        accepted: nil
      )
      quote2 = create(:quote,
        customer_request_id: customer_request2.id,
        company_id: company.id,
        accepted: true
      )
      contract = create(:contract,
        quote_id: quote2.id,
        customer_request_id: customer_request2.id,
        completion_date: nil)
      expect(customer.completed_quotes).not_to include(quote2)
    end

    it 'should not return quotes that have not been accepted' do
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
        company_id: company.id,
        accepted: nil
      )
      quote2 = create(:quote,
        customer_request_id: customer_request2.id,
        company_id: company.id,
        accepted: true
      )
      contract = create(:contract,
        quote_id: quote2.id,
        customer_request_id: customer_request2.id,
        completion_date: nil)
      expect(customer.completed_quotes).not_to include(quote1)
    end
  end
end
