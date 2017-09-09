# == Schema Information
#
# Table name: customer_requests
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  address             :string
#  city                :string
#  state               :string
#  zipcode             :string
#  service_category_id :integer
#  description         :text
#  customer_id         :integer
#  expires_date        :date
#  latitude            :float
#  longitude           :float
#
# Indexes
#
#  index_customer_requests_on_expires_date  (expires_date)
#
require 'rails_helper'


RSpec.describe CustomerRequestsController, type: :controller do
  describe 'GET #index' do
    context 'company signed in' do

      before :each do
        sign_in create :company, status: 'Active'
      end

      it 'assigns all eligible customer request to @requests' do
        allow(controller).to receive(:validate_customer_request!).and_return(true)
        all_requests = [
          create(:customer_request),
          create(:customer_request)
        ]
        allow_any_instance_of(Company).to receive(:eligible_customer_requests).and_return(all_requests)
        get :index
        expect(assigns(:requests)).to eq(all_requests)
      end

      it 'renders the index html' do
        get :index
        expect(response).to render_template('index.html.erb')
      end

      it 'doesn\'t assign expired customer request to @requests' do
        service_category = create(:service_category)
        company = create(:company,
          status: 'Active',
          latitude: 41.9013087,
          longitude: -87.68276759999999,
          service_radius: 100.0
        )
        sign_in company
        create(:company_service,
          service_category_id: service_category.id,
          company_id: company.id
        )
        customer_request_1 = create(:customer_request,
          latitude: 41.9013087,
          longitude: -87.68276759999999,
          service_category_id: service_category.id,
          expires_date: Date.today + 2
        )
        create(:customer_request,
          latitude: 41.9013087,
          longitude: -87.68276759999999,
          service_category_id: service_category.id,
          expires_date: Date.today - 2
        )

        get :index
        expect(assigns(:requests)).to match_array([customer_request_1])
      end

    end

    context 'company not signed in' do
      it 'redirects to the company sign in page' do
        get :index
        expect(response).to redirect_to('/')
      end
    end

    context 'company has a pending status' do

      before :each do
        @company = create :company, status: 'Pending'
        sign_in @company
      end

      it 'redirects company to their show page' do
        get :index
        expect(response).to redirect_to("/companies/#{@company.id}")
      end
    end

    context 'customer signed in' do

      before :each do
        @customer = create :customer
        sign_in @customer
      end

      it 'does not show customer expired customer requests' do
        customer_request_1 = create(:customer_request,
          customer_id: @customer.id,
          expires_date: Date.today
        )
        customer_request_3 = create(:customer_request,
          customer_id: @customer.id,
          expires_date: Date.today - 11
        )
        get :index
        expect(assigns(:requests)).to eq([customer_request_1])
      end
    end
  end

  describe 'GET #new' do
    context 'customer signed in' do

      before :each do
        sign_in create :customer
      end

      it 'should create a new customer request' do
        get :new
        expect(assigns(:customer_request)).to be_a_new(CustomerRequest)
      end

      it 'assigns all service categories to @categories' do
        all_categories = [
          create(:service_category),
          create(:service_category)
        ]
        get :new
        expect(assigns(:categories)).to eq(all_categories)
      end

      it 'renders the new html' do
        get :new
        expect(response).to render_template('new.html.erb')
      end
    end

    context 'customer not signed in' do
      it 'redirects to the customer sign in page' do
        get :new
        expect(response).to redirect_to('/customers/sign_in')
      end
    end
  end

  describe 'POST #create' do
    it 'creates and saves a new customer request to the database' do
      sign_in create(:customer)
      service_category = create(:service_category)
      expect{
        post :create, params: { customer_request: attributes_for(:customer_request, service_category_id: service_category.id)}
      }.to change(CustomerRequest, :count).by(1)
    end
    it 'redirects to the customer_requests index' do
      customer = create(:customer)
      sign_in customer
      service_category = create(:service_category)
      post :create, params: {
        customer_request: attributes_for(
          :customer_request,
          service_category_id: service_category.id
        )
      }
      expect(response).to redirect_to("/customers/#{customer.id}")
    end
  end

  describe 'GET #show' do

    before :each do
      @customer_request = create(:customer_request)
    end

    context 'company signed in' do
      before :each do
        allow_any_instance_of(Company).to receive_message_chain(
          :eligible_customer_requests, :include?
        ).and_return(true)
        company = create :company
        sign_in company
        create :quote,
          customer_request_id: @customer_request.id,
          company_id: company.id
      end

      it 'assigns the requested customer_request to @request' do
        get :show, params: { id: @customer_request.id }
        expect(assigns(:request)).to eq(@customer_request)
      end

      it 'renders the show page' do
        get :show, params: { id: @customer_request.id }
        expect(response).to render_template :show
      end
    end

    context 'customer signed in' do
      it 'assigns current customer\'s customer_request to @request' do
      end
    end
  end

  describe 'PATCH #update' do
    it 'assigns all the service categories to @service_categories' do
      customer = create :customer
      sign_in customer
      customer_request = create(
        :customer_request,
        customer: customer,
      )
      service_category = create :service_category
      put :update, params: {
        id: customer_request.id,
        customer_request: { id: customer_request.id }
      }
      expect(assigns(:categories)).to match_array(
        [service_category, customer_request.service_category]
      )
    end

    context 'with valid attributes' do
      it 'updates the values of the customer_request' do
        customer = create(:customer)
        customer_request = create(:customer_request,
          city: 'old city',
          description: 'old description',
          customer: customer
        )
        sign_in customer
        put :update, params: {
          id: customer_request.id,
          customer_request: {
            city: 'new city',
            description: 'new description'
          }
        }
        customer_request.reload
        expect(customer_request.city).to eq('new city')
        expect(customer_request.description).to eq('new description')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the contact' do
      end
      it 're-renders the :edit template' do
      end
    end

  end

  describe 'GET #edit' do
    context 'customer signed in' do
      before :each do
        customer = create(:customer)
        sign_in customer
        @customer_request = create(:customer_request, customer: customer)
      end

      it 'assigns the requested request to @customer_request' do
        get :edit, params: { id: @customer_request.id }
        expect(assigns(:customer_request)).to eq(@customer_request)
      end

      it 'renders edit page' do
        get :edit, params: { id: @customer_request.id }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      customer = create :customer
      sign_in customer
      @customer_request = create :customer_request, customer: customer
    end

    context 'request not under contract' do
      context 'delete successful' do
        it 'redirects to the index page' do
          delete :destroy, params: { id: @customer_request.id }
          expect(response).to redirect_to '/customer_requests'
        end

        it 'removes the customer request form the database' do
          expect{
            delete :destroy, params: { id: @customer_request.id }
          }.to change(CustomerRequest, :count).by(-1)
        end

        it 'updates the flash message' do
          delete :destroy, params: { id: @customer_request.id }
          expect(flash[:success]).to eq(
            "#{@customer_request.description} has been successfully cancelled"
          )
        end
      end

      context 'delete unsuccessful' do
        before :each do
          allow_any_instance_of(
            CustomerRequest
          ).to receive(:destroy).and_return(false)
        end

        it 'redirects to the edit page' do
          delete :destroy, params: { id: @customer_request.id }
          expect(response).to render_template :edit
        end

        it 'does not delete from the database' do
          expect{
            delete :destroy, params: { id: @customer_request.id }
          }.to change(CustomerRequest, :count).by(0)
        end

        it 'updates the flash message' do
          delete :destroy, params: { id: @customer_request.id }
          expect(flash[:notice]).to eq(
            'Something went wrong, please try again.'
          )
        end
      end
    end

    context 'request under contract' do
      before :each do
        create :contract, customer_request: @customer_request
      end

      it 'renders the edit view' do
        delete :destroy, params: { id: @customer_request.id }
        expect(response).to render_template :edit
      end

      it 'does not delete from the database' do
        expect{
          delete :destroy, params: { id: @customer_request.id }
        }.to change(CustomerRequest, :count).by(0)
      end

      it 'updates the flash message' do
        delete :destroy, params: { id: @customer_request.id }
        expect(flash[:notice]).to eq(
          'This request is under contract and cannot be cancelled'
        )
      end
    end
  end
end
