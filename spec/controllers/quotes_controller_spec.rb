require 'rails_helper'

RSpec.describe QuotesController, type: :controller do
  describe 'GET #index' do 
    it 'assigns the proper quotes to @quotes' do 
      customer = create(:customer)
      create(:customer_request, customer_id: customer_id)
      sign_in customer
      q1 = create(:quote, customer_id: customer.id)
      q2 = create(:quote, customer_id: customer.id)
      q3 = create(:quote, customer_id: customer.id)
      get :index
      expect(assigns(:quotes)).to eq([q1, q2, q3])
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
