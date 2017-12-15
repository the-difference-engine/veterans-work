# == Schema Information
#
# Table name: quotes
#
#  id                       :integer          not null, primary key
#  customer_request_id      :integer
#  company_id               :integer
#  materials_cost_estimate  :decimal(, )
#  labor_cost_estimate      :decimal(, )
#  start_date               :date
#  completion_date_estimate :date
#  notes                    :text
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  accepted                 :boolean
#  customer_viewed          :boolean          default(FALSE)
#  view_date                :date
#

require 'rails_helper'
RSpec.describe QuotesController, type: :controller do
  describe 'GET #index' do
    context 'with customer signed in' do

      it 'assigns all the customers open quotes to @open_quotes' do
        company1 = create(:company)
        company2 = create(:company)
        customer = create(:customer)
        sign_in customer
        cr1 = create(:customer_request, customer_id: customer.id)
        cr2 = create(:customer_request, customer_id: customer.id)
        cr3 = create(:customer_request, customer_id: customer.id)
        q1 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr1.id,
          accepted: nil
          )
        q2 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr2.id,
          accepted: true
          )
        q3 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr3.id,
          accepted: nil
          )
        q4 = create(:quote,
          company_id: company2.id,
          customer_request_id: cr1.id,
          accepted: true
          )
        q5 = create(:quote,
          company_id: company2.id,
          customer_request_id: cr2.id,
          accepted: nil
          )
        get :index
        expect(assigns(:open_quotes)).to include(q1, q3, q5)
        expect(assigns(:open_quotes)).to_not include(q2, q4)
      end

      it 'assigns all the customers accepted quotes to @accepted_quotes' do
        company1 = create(:company)
        company2 = create(:company)
        customer = create(:customer)
        sign_in customer
        cr1 = create(:customer_request, customer_id: customer.id)
        cr2 = create(:customer_request, customer_id: customer.id)
        cr3 = create(:customer_request, customer_id: customer.id)
        q1 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr1.id,
          accepted: false
          )
        q2 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr2.id,
          accepted: true
          )
        q3 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr3.id,
          accepted: nil
          )
        q4 = create(:quote,
          company_id: company2.id,
          customer_request_id: cr1.id,
          accepted: true
          )
        q5 = create(:quote,
          company_id: company2.id,
          customer_request_id: cr2.id,
          accepted: false
          )
        create(:contract, quote_id: q2.id, completion_date: nil)
        create(:contract, quote_id: q4.id, completion_date: nil)
        get :index
        expect(assigns(:accepted_quotes)).to_not include(q1, q3, q5)
        expect(assigns(:accepted_quotes)).to include(q2, q4)
      end

      it 'assigns all the customers declined quotes to @declined_quotes' do
        company1 = create(:company)
        company2 = create(:company)
        customer = create(:customer)
        sign_in customer
        cr1 = create(:customer_request, customer_id: customer.id)
        cr2 = create(:customer_request, customer_id: customer.id)
        cr3 = create(:customer_request, customer_id: customer.id)
        q1 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr1.id,
          accepted: false
          )
        q2 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr2.id,
          accepted: true
          )
        q3 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr3.id,
          accepted: nil
          )
        q4 = create(:quote,
          company_id: company2.id,
          customer_request_id: cr1.id,
          accepted: true
          )
        q5 = create(:quote,
          company_id: company2.id,
          customer_request_id: cr2.id,
          accepted: false
          )
        create(:contract, quote_id: q2.id, completion_date: nil)
        create(:contract, quote_id: q4.id, completion_date: nil)
        get :index
        expect(assigns(:declined_quotes)).to include(q1, q5)
        expect(assigns(:declined_quotes)).to_not include(q2, q3, q4)
      end

      it 'assigns all the customers completed quotes to @completed_quotes' do
        company1 = create(:company)
        company2 = create(:company)
        customer = create(:customer)
        sign_in customer
        cr1 = create(:customer_request, customer_id: customer.id)
        cr2 = create(:customer_request, customer_id: customer.id)
        cr3 = create(:customer_request, customer_id: customer.id)
        q1 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr1.id,
          accepted: false
          )
        q2 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr2.id,
          accepted: true
          )
        q3 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr3.id,
          accepted: nil
          )
        q4 = create(:quote,
          company_id: company2.id,
          customer_request_id: cr1.id,
          accepted: true
          )
        q5 = create(:quote,
          company_id: company2.id,
          customer_request_id: cr2.id,
          accepted: false
          )
        q2contract = create(:contract, quote_id: q2.id, completion_date: 1.day.from_now)
        create(:contract, quote_id: q4.id, completion_date: nil)
        get :index
        expect(assigns(:completed_quotes)).to_not include(q1, q3, q4, q5)
        expect(assigns(:completed_quotes)).to include(q2)
      end

      it 'filters quotes by customer request id if there are query parameters' do
        company1 = create(:company)
        company2 = create(:company)
        customer = create(:customer)
        sign_in customer
        cr1 = create(:customer_request, customer_id: customer.id)
        cr2 = create(:customer_request, customer_id: customer.id)
        cr3 = create(:customer_request, customer_id: customer.id)
        q1 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr1.id,
          accepted: false
          )
        q2 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr2.id,
          accepted: true
          )
        q3 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr3.id,
          accepted: nil
          )
        q4 = create(:quote,
          company_id: company2.id,
          customer_request_id: cr1.id,
          accepted: true
          )
        q5 = create(:quote,
          company_id: company2.id,
          customer_request_id: cr2.id,
          accepted: false
          )
        q2contract = create(:contract, quote_id: q2.id, completion_date: 1.day.from_now)
        create(:contract, quote_id: q4.id, completion_date: nil)
        get :index, params: { request_id: cr1.id }
        expect(assigns(:open_quotes)).to_not include(q3)
        expect(assigns(:accepted_quotes)).to include(q4)
        expect(assigns(:declined_quotes)).to_not include(q5)
        expect(assigns(:declined_quotes)).to include(q1)
        expect(assigns(:completed_quotes)).to_not include(q2)
      end
    end

    context 'with company signed in' do
      it "assigns all the company's open quotes to @open_quotes" do
        company1 = create(:company)
        sign_in company1
        q1 = create(:quote, company_id: company1.id, accepted: nil)
        q2 = create(:quote, company_id: company1.id, accepted: true)
        q3 = create(:quote, company_id: company1.id, accepted: nil)
        get :index
        expect(assigns(:open_quotes)).to include(q1, q3)
        expect(assigns(:open_quotes)).not_to include(q2)
      end

      it "assigns all the company's accepted quotes to @accepted_quotes" do
        company1 = create(:company)
        sign_in company1
        q1 = create(:quote, company_id: company1.id, accepted: nil)
        q2 = create(:quote, company_id: company1.id, accepted: true)
        q3 = create(:quote, company_id: company1.id, accepted: nil)
        create(:contract, quote_id: q2.id, completion_date: nil)
        get :index
        expect(assigns(:accepted_quotes)).to include(q2)
        expect(assigns(:accepted_quotes)).not_to include(q1, q3)
      end

      it "assigns all the company's declined quotes to @declined_quotes" do
        company1 = create(:company)
        sign_in company1
        q1 = create(:quote, company_id: company1.id, accepted: false)
        q2 = create(:quote, company_id: company1.id, accepted: true)
        q3 = create(:quote, company_id: company1.id, accepted: nil)
        create(:contract, quote_id: q2.id, completion_date: nil)
        get :index
        expect(assigns(:declined_quotes)).to include(q1)
        expect(assigns(:declined_quotes)).not_to include(q2, q3)
      end

      it "assigns all the company's completed quotes to @completed_quotes" do
        company1 = create(:company)
        sign_in company1
        q1 = create(:quote, company_id: company1.id, accepted: false)
        q2 = create(:quote, company_id: company1.id, accepted: true)
        q3 = create(:quote, company_id: company1.id, accepted: nil)
        create(:contract, quote_id: q2.id, completion_date: Time.current)
        get :index
        expect(assigns(:completed_quotes)).to include(q2)
        expect(assigns(:completed_quotes)).not_to include(q1, q3)
      end

      it 'filters quotes by customer request id if there are query parameters' do
        company1 = create(:company)
        customer = create(:customer)
        sign_in company1
        cr1 = create(:customer_request, customer_id: customer.id)
        cr2 = create(:customer_request, customer_id: customer.id)
        cr3 = create(:customer_request, customer_id: customer.id)
        cr4 = create(:customer_request, customer_id: customer.id)
        q1 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr1.id,
          accepted: false
          )
        q2 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr2.id,
          accepted: true
          )
        q3 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr3.id,
          accepted: nil
          )
        q4 = create(:quote,
          company_id: company1.id,
          customer_request_id: cr4.id,
          accepted: true
          )
        q2contract = create(:contract, quote_id: q2.id, completion_date: 1.day.from_now)
        create(:contract, quote_id: q4.id, completion_date: nil)
        get :index, params: { request_id: cr1.id }
        expect(assigns(:open_quotes)).to_not include(q3)
        expect(assigns(:accepted_quotes)).to_not include(q4)
        expect(assigns(:declined_quotes)).to include(q1)
        expect(assigns(:completed_quotes)).to_not include(q2)
      end      
    end

    context 'without customer or company signed in' do
      it 'redirects to the root' do
        get :index
        expect(response).to redirect_to('/')
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
      @customer_request = create(:customer_request)
      @company_one = create(:company)
      @company_two = create(:company)
      @company_three = create(:company)
      sign_in @company_one
    end

    it 'does not create a new quote if 3 quotes already exist' do
      quote_one = create(
        :quote,
        company_id: @company_one.id,
        customer_request_id: @customer_request.id
      )
      quote_two = create(
        :quote,
        company_id: @company_two.id,
        customer_request_id: @customer_request.id
      )
      quote_three = create(
        :quote,
        company_id: @company_three.id,
        customer_request_id: @customer_request.id
      )
      expect{
        post :create, params: {
          quote: attributes_for(:quote),
          customer_request_id: @customer_request.id
        }
      }.to change(Quote, :count).by(0)
    end

    it 'does not create a quote if they dont have enough credits' do
      @company_four = create(:company, :without_credits)
      sign_in @company_four

      expect{
        post :create, params: {
          quote: attributes_for(:quote),
          customer_request_id: @customer_request.id
          }
      }.to change(Quote, :count).by(0)

    end

    it 'creates and saves a new company quote to the database' do
      expect{
        post :create, params: {
          quote: attributes_for(:quote),
          customer_request_id: @customer_request.id
        }
      }.to change(Quote, :count).by(1)
    end

    it 'lowers the company credits after creating quote' do
       post :create, params: {
          quote: attributes_for(:quote),
          customer_request_id: @customer_request.id
        }

        @company_one.reload

        expect(@company_one.credits).to eq(9)
    end

    it 'replaces blank values in any cost field with 0' do
      post :create, params: {
        quote: attributes_for(:quote, :blank_costs),
        customer_request_id: @customer_request.id
      }
      expect(Quote.last.total_cost_estimate).to eq(0)
    end

    it 'does not replace non-blank values in any cost field with 0' do
      post :create, params: {
        quote: attributes_for(:quote),
        customer_request_id: @customer_request.id
      }
      expect(Quote.last.total_cost_estimate).to eq(200)
    end

    it 'renders new.html.erb if quote doesn\'t save' do
      allow_any_instance_of(Quote).to receive(:save).and_return(false)
      post :create, params: {
        quote: attributes_for(:quote),
        customer_request_id: @customer_request.id
      }
      expect(response).to render_template('new.html.erb')
    end
  end

  describe 'GET #show' do
    it 'assigns the requested quote to @quote' do
      quote = create(:quote)
      get :show, params: {id: quote.id}
      expect(assigns(:quote)).to eq(quote)
    end

    it 'updates customer_viewed to true if it is the current_customer clicking
    on the quote' do
      customer = create(:customer)
      sign_in customer
      customer_request = create(:customer_request, customer_id: customer.id)
      quote = create(:quote, customer_request_id: customer_request.id)
      get :show, params: {id: quote.id}
      quote.reload
      expect(quote.customer_viewed).to eq(true)
    end

    it 'does not update customer_viewed to true if a company clicks
    on the quote' do
      company = create(:company)
      sign_in company
      customer_request = create(:customer_request)
      quote = create(:quote, customer_request_id: customer_request.id)
      get :show, params: {id: quote.id}
      quote.reload
      expect(quote.customer_viewed).to eq(false)
    end
  end

  describe 'PATCH #update' do
    context 'when current_customer is logged in' do
      it 'assigns the requested quote to @quote' do 
        customer = create(:customer)
        sign_in customer
        quote = create(:quote)
        patch :update, params: {id: quote.id}
        quote.reload
        expect(quote.accepted).to eq(false)
      end

      it 'assigns the quote id' do
        customer = create(:customer)
        sign_in customer
        quote = create(:quote)
        patch :update, params: {id: quote.id}
        expect(assigns(:quote)).to eq(quote)
      end
    end

    context 'when current_customer is not logged in' do
      it 'redirects to the quotes show page if not current_customer' do
        quote = create(:quote)
        patch :update, params: {id: quote.id}
        expect(response).to redirect_to("/quotes/#{quote.id}")
      end
    end
  end
end
