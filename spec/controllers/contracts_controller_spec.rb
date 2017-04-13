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

RSpec.describe ContractsController, type: :controller do


  describe 'POST #create' do
    before :each do
      @company_one = create(:company)
      @company_two = create(:company)
      @company_three = create(:company)
      @customer_request = create(:customer_request)
      @quote_one = create(:quote,
        company_id: @company_one.id,
        customer_request_id: @customer_request.id
      )
      @quote_two = create(:quote,
        company_id: @company_two.id,
        customer_request_id: @customer_request.id
      )
      @quote_three = create(:quote,
        company_id: @company_three.id,
        customer_request_id: @customer_request.id
      )
    end

    it 'creates and saves a new contract to the database' do
      expect{
        post :create, params: {
          id: @quote_one.id
          }
        }.to change(Contract, :count).by(1)
    end

    it 'sends an email to each company that has created a quote' do
      expect {
        post :create, params: {
          id: @quote_one.id
        }
      }.to change { ActionMailer::Base.deliveries.count }.by(3)
    end
  end
end
