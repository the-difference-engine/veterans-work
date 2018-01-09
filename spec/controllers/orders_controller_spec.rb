# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  company_id :integer
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  total      :decimal(6, 2)
#

require 'rails_helper'


RSpec.describe OrdersController, type: :controller do
  before :each do
    WebMock.allow_net_connect!
  end

  describe 'GET #index' do
    context 'admin signed in' do
      before :each do
        sign_in create :admin
      end

      it 'assigns all orders to @orders' do
        order_1 = create :order
        order_2 = create :order
        order_3 = create :order
        get :index
        expect(assigns(:orders)).to match_array([order_1, order_2, order_3])
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    context 'company signed in' do
      before :each do
        @company = create :company
        sign_in @company
      end

      it 'assigns the current companys orders to @orders' do
        order_1 = create :order, company: @company
        order_2 = create :order, company: @company
        create :order
        get :index
        expect(assigns(:orders)).to match_array([order_1, order_2])
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    context 'no one signed in' do
      it 'redirects to root' do
        get :index
        expect(response).to redirect_to '/'
      end
    end
  end

  describe 'GET #new' do
    it 'redirects to customer request page' do
      get :new
      expect(response).to redirect_to '/customer_requests'
    end
  end

  describe 'POST #create' do
    before :each do
      @company = create :company, status: 'Active', credits: 2
      sign_in @company
    end

    context 'Company purchases 5 credits' do
      it 'Adds order to database' do
        expect{
          post :create, params: {
                                  'companyId' => @company.id,
                                  'quantity' => 5,
                                  'total' => 25.00
                                }
        }.to change(Order, :count).by(1)
      end
    end

    it 'Company credits updated to 7' do
      post :create, params: {
                              'companyId' => @company.id,
                              'quantity' => 5,
                              'total' => 25.00
                            }

      @company.reload
      expect(@company.credits).to eq(7)
    end
  end

  describe 'GET #show' do
    context 'company signed in' do
      before :each do
        company = create :company
        sign_in company
        @order = create :order, company: company
      end

      it 'assigns the requested order to @order' do
        get :show, params: { id: @order.id }
        expect(assigns(:order)).to eq(@order)
      end

      it 'renders the show template' do
        get :show, params: { id: @order.id }
        expect(response).to render_template :show
      end
    end

    context 'company not signed in' do
      it 'redirect to root' do
        order = create :order
        get :show, params: { id: order.id }
        expect(response).to redirect_to '/'
      end
    end
  end
end
