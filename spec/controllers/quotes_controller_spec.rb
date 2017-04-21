require 'rails_helper'

RSpec.describe QuotesController, type: :controller do
  describe 'GET #index' do
    context 'with customer signed in' do
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

    context 'with company signed in' do
      it 'assigns all the company\'s quotes to @quotes' do
        company1 = create(:company)
        company2 = create(:company)
        sign_in company1
        q1 = create(:quote, company_id: company1.id)
        q2 = create(:quote, company_id: company1.id)
        q3 = create(:quote, company_id: company1.id)
        create(:quote, company_id: company2.id)
        get :index
        expect(assigns(:quotes)).to eq([q1, q2, q3])
      end
    end
  end

  describe 'GET #new' do
    it 'renders a new form' do
      sign_in create(:company)
      get :new
      expect(response).to render_template("new.html.erb")
    end
  end

  describe 'POST #create' do
    before :each do
      sign_in create(:company)
    end

    it 'creates and saves a new customer quote to the database' do
      expect{
        post :create, params: {
          quote: attributes_for(:quote)
        }
      }.to change(Quote, :count).by(1)
    end

    it 'replaces blank values in any cost field with 0' do
      post :create, params: {
        quote: attributes_for(:quote, :blank_costs)
      }
      expect(Quote.last.total_cost_estimate).to eq(0)
    end

    it 'does not replace non-blank values in any cost field with 0' do
      post :create, params: {
        quote: attributes_for(:quote)
      }
      expect(Quote.last.total_cost_estimate).to eq(200)
    end
  end
end
