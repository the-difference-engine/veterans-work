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
    it 'assigns a new instance of order to @order' do
      get :new
      expect(assigns(:order)).to be_an_instance_of(Order)
    end
  end

  describe 'POST #create' do
    before :each do
      sign_in create :company
      OrdersController.any_instance.stub(:process_payment).and_return(nil)
    end

    it 'assigns a new instance of order with passed attributes to @order' do
      sign_in create :company
      post :create, params: { order: attributes_for(:order) }
      expect(assigns(:order)).to be_an_instance_of(Order)
    end

    context 'instance saves' do
      it 'saves a new order to the database' do
        expect{
          post :create, params: { order: attributes_for(:order) }
        }.to change(Order, :count).by(1)
      end

      it 'updates the flash message' do
        post :create, params: { order: attributes_for(:order) }
        expect(flash[:success]).to eq('Your order has been successfully processed.')
      end

      it 'redirects the user to the created orders show page' do
        post :create, params: { order: attributes_for(:order) }
        expect(response).to redirect_to order_path(assigns(:order))
      end
    end

    context 'instance doesnt save' do
      before :each do
        allow_any_instance_of(Order).to receive(:save).and_return(false)
      end

      it 'updates the flash message' do
        post :create, params: { order: attributes_for(:order) }
        expect(flash[:danger]).to eq('Something went wrong please submit again.')
      end

      it 'renders the new template' do
        post :create, params: { order: attributes_for(:order) }
        expect(response).to render_template :new
      end
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
