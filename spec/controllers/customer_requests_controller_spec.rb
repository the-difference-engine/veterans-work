require 'rails_helper'

RSpec.describe CustomerRequestsController, type: :controller do
  describe 'GET #index' do
    it 'assigns all customer request to @requests' do
      all_requests = [
        create(:customer_request),
        create(:customer_request)
      ]
      get :index
      expect(assigns(:requests)).to eq(all_requests)
    end
    it 'renders the index html' do
      get :index
      expect(response).to render_template("index.html.erb")
    end
  end

  describe 'GET #new' do
    it 'should create a new customer request' do
      get :new
      # expect(assigns(:customer_request)).to be_a(CustomerRequest)
      expect(assigns(:customer_request)).to be_a_new(CustomerRequest)
    end
    it 'assigns all service categories to @rcategories' do
      all_categories = [
        create(:service_category),
        create(:service_category)
      ]
      get :new
      expect(assigns(:categories)).to eq(all_categories)
    end
    it 'renders the new html' do
      get :new
      expect(response).to render_template("new.html.erb")
    end

  end

  describe 'POST #create' do
    it 'creates and saves a new customer request to the database' do
      expect{
        post :create, customer_request: attributes_for(:customer_request)
      }.to change(CustomerRequest, :count).by(1)
    end
    it 'redirects to the customer_requests index' do
      post :create, customer_request: attributes_for(:customer_request)
      expect(response).to redirect_to("/customer_requests")
    end
  end

  describe 'GET #show' do
    it 'assigns the requested customer_request to @request' do
      customer_request = create(:customer_request)
      get :show, params: { id: customer_request.id }
      expect(assigns(:request)).to eq(customer_request)
    end
    it 'renders the show page' do
    end
  end

  describe 'GET #edit' do
    it '' do
    end
    it '' do
    end
  end

  describe 'PATCH #update' do
    it '' do
    end
    it '' do
    end
  end

  describe 'DELETE #destroy' do
    it '' do
    end
    it '' do
    end
  end
end
