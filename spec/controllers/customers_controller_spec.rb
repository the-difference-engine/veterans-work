require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'GET #show' do
    it 'assigns the requested customer to @customer' do
      customer = create(:customer)
      get :show, params: { id: customer.id }
      expect(assigns(:customer)).to eq(customer)
    end
  end
end
