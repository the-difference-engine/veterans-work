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
#

RSpec.describe QuotesController, type: :controller do
  describe 'GET #index' do
    context 'with customer signed in' do
      context 'with request_id param' do
        it 'assigns the proper customer_requests to @customer_requests' do
          customer = create(:customer)
          sign_in customer
          cr1 = create(:customer_request, customer_id: customer.id)
          create(:customer_request, customer_id: customer.id)
          create(:customer_request, customer_id: customer.id)
          get :index, params: { request_id: cr1.id }
          expect(assigns(:customer_requests)).to match_array [cr1]
        end
      end

      it 'assigns the proper customer_requests to @customer_requests' do
        customer = create(:customer)
        sign_in customer
        cr1 = create(:customer_request, customer_id: customer.id)
        cr2 = create(:customer_request, customer_id: customer.id)
        cr3 = create(:customer_request, customer_id: customer.id)
        get :index
        expect(assigns(:customer_requests)).to match_array [cr1, cr2, cr3]
      end

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
    end

    context 'with company signed in' do
      it "assigns all the company's open quotes to @open_quotes" do
        company1 = create(:company)
        sign_in company1
        q1 = create(:quote, company_id: company1.id, accepted: nil)
        q2 = create(:quote, company_id: company1.id, accepted: true)
        q3 = create(:quote, company_id: company1.id, accepted: nil)
        get :index
        expect(assigns(:open_quotes)).to eq([q1, q3])
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

    it 'creates and saves a new company quote to the database' do
      expect{
        post :create, params: {
          quote: attributes_for(:quote),
          customer_request_id: @customer_request.id
        }
      }.to change(Quote, :count).by(1)
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
  end
end
