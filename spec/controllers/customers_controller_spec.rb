require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'GET #show' do
    it 'assigns the requested customer to @customer' do
      customer = create(:customer,
      email: "example@gmail.com")
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
      expect(:customer).to redirect_to("/")
    end
  end
end
