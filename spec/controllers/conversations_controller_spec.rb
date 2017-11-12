require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do


  describe 'GET #index' do
    context 'company signed in' do
      it 'assigns all conversations for that company to @conversations' do
          company = create :company
          customer = create :customer
          customer_request_1 = create :customer_request, customer_id: customer.id
          quote_1 = create :quote, customer_request_id: customer_request_1.id, company_id: company.id
          conversation_1 = create :conversation, quote_id: quote_1.id, company_id: company.id, customer_id: customer.id
          sign_in company
          get :index
          expect(assigns(:conversations)).to match_array [conversation_1]
      end
    end
    context 'customer signed in' do
      it 'assigns all conversations for that customer to @conversations' do
          company = create :company
          customer = create :customer
          customer_request_1 = create :customer_request, customer_id: customer.id
          quote_1 = create :quote, customer_request_id: customer_request_1.id, company_id: company.id
          conversation_1 = create :conversation, quote_id: quote_1.id, company_id: company.id, customer_id: customer.id
          sign_in customer
          get :index
          expect(assigns(:conversations)).to match_array [conversation_1]
      end
    end

  end

  describe '#create' do
    context 'no one is signed in' do
      it 'should not create a conversation' do
        quote = create :quote
        expect{
          post :create, params: {quote_id: quote.id}
        }.to change(Conversation, :count).by 0
      end
    end
    context 'customer is signed in' do
      it 'should create a conversation' do
        customer = create :customer
        company = create :company
        customer_request = create :customer_request, customer_id: customer.id
        quote = create :quote, customer_request_id: customer_request.id, company_id: company.id
        sign_in customer
        expect{
          post :create, params: {quote_id: quote.id}
        }.to change(Conversation, :count).by 1
      end
    end

    context 'company is signed in' do
      it 'should create a conversation' do
        customer = create :customer
        company = create :company
        customer_request = create :customer_request, customer_id: customer.id
        quote = create :quote, customer_request_id: customer_request.id, company_id: company.id
        sign_in company
        expect{
          post :create, params: {quote_id: quote.id}
        }.to change(Conversation, :count).by 1
      end
    end
  end

  describe '#show' do
    before :each do
        @customer = create :customer
        @company = create :company
        @customer_request = create :customer_request, customer_id: @customer.id
        @quote = create :quote, customer_request_id: @customer_request.id, company_id: @company.id
        @conversation = create :conversation, quote_id: @quote.id, customer_id: @customer.id, company_id: @company.id
    end
    it 'should assign the conversation to @conversation' do
        sign_in @customer
        get :show, params: {id: @conversation.id}
        expect(assigns(:conversation)).to eq(@conversation)
    end
    context 'company is signed in' do 
      it 'should assign @me to the current_company' do
        sign_in @company
        get :show, params: {id: @conversation.id}
        expect(assigns(:me)).to eq(@company)
      end
    end
    context 'no messages have been created for the conversation' do
      it 'should render the show page' do
        sign_in @company
        get :show, params: {id: @conversation.id}
        expect(response).to render_template('show.html.erb')
      end
    end
  end

  describe '#message' do
    context 'customer signed in' do
      it 'creates and saves a new message to the database' do
          @customer = create :customer
          @company = create :company
          @customer_request = create :customer_request, customer_id: @customer.id
          @quote = create :quote, customer_request_id: @customer_request.id, company_id: @company.id
          @conversation = create :conversation, quote_id: @quote.id, customer_id: @customer.id, company_id: @company.id
          sign_in @customer
          expect{
            post :message, params: {
              id: @conversation.id, body: "testing", customer_id: @customer.id
            }
          }.to change(Message, :count).by(1)
      end
    end
    context 'company signed in' do
      it 'creates and saves a new message to the database' do
          @customer = create :customer
          @company = create :company
          @customer_request = create :customer_request, customer_id: @customer.id
          @quote = create :quote, customer_request_id: @customer_request.id, company_id: @company.id
          @conversation = create :conversation, quote_id: @quote.id, customer_id: @customer.id, company_id: @company.id
          sign_in @company
          expect{
            post :message, params: {
              id: @conversation.id, body: "testing", company_id: @company.id
            }
          }.to change(Message, :count).by(1)
      end
    end
  end
end