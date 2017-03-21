require 'rails_helper'

RSpec.describe QuotesController, type: :controller do
  describe 'GET #index' do 
    it 'assigns the proper customer_request to @customer_requests' do 
      customer = create(:customer)
      sign_in customer
      cr1 = create(:customer_request, customer_id: customer.id)
      cr2 = create(:customer_request, customer_id: customer.id)
      cr3 = create(:customer_request, customer_id: customer.id)
      get :index
      expect(assigns(:customer_requests)).to eq([cr1, cr2, cr3])
    end
  end

  describe 'GET #new' do
    it 'renders a new form' do
      get :new
      expect(response).to render_template("new.html.erb")
    end
  end

  describe 'POST #create' do
    it 'creates a and saves a new customer quote to the database' do
      sign_in create(:company)
      expect{
        post :create, params: {
          quote: attributes_for(:quote)
        }
      }.to change(Quote, :count).by(1)
    end
  end
end
