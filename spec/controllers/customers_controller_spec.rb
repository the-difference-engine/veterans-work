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
#
# Indexes
#
#  index_customers_on_email                 (email) UNIQUE
#  index_customers_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'GET #show' do
    it 'assigns the requested customer to @customer' do
      customer = create(:customer)
      sign_in customer
      get :show, params: { id: customer.id }
      expect(assigns(:customer)).to eq(customer)
    end
    it 'redirects a user trying to access another users show page' do
      customer1 = create(:customer,
      email: "test@gmail.com", id: 20)
      customer = create(:customer,
      email: "example@gmail.com", id: 100)
      sign_in customer
      get :show, params: { id: 20 }
      expect(response).to redirect_to("/")
    end
  end
end
