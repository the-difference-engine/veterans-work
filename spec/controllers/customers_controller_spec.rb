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
  describe 'Canelled account' do
    it 'should destroy all items associated to cancelled customer' do
      customer = create(:customer)
      sign_in customer
      review = create(:review, customer_id: customer.id)
      customer_request = create(:customer_request, customer_id: customer.id)
      customer.destroy
      expect { review.reload }.to raise_error ActiveRecord::RecordNotFound
      expect { customer_request.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
