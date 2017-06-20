# == Schema Information
#
# Table name: admins
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
#
# Indexes
#
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  describe 'GET #index' do
    context 'with admin signed in' do
      it 'assigns the last 10 customers to @customers' do
        sign_in create :admin
        11.times do
          create :customer
          create :company
          create :customer_request
          create :quote
        end
        get :index
        expect(assigns(:recent_customers)).to eq(Customer.last(10))
        expect(assigns(:recent_companies)).to eq(Company.last(10))
        expect(assigns(:recent_customer_requests)).to eq(CustomerRequest.last(10))
        expect(assigns(:recent_quotes)).to eq(Quote.last(10))
      end
    end

    context 'without admin signed in' do
      it 'redirects to root' do
        get :index
        expect(response).to redirect_to '/admins/sign_in'
      end
    end
  end
end
