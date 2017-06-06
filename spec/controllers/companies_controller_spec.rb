# == Schema Information
#
# Table name: companies
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  zip_code               :string
#  phone                  :string
#  description            :text
#  url                    :string
#  latitude               :float
#  longitude              :float
#  address                :string
#  city                   :string
#  state                  :string
#  service_radius         :float
#  status                 :string           default("Pending")
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#
# Indexes
#
#  index_companies_on_confirmation_token    (confirmation_token) UNIQUE
#  index_companies_on_email                 (email) UNIQUE
#  index_companies_on_reset_password_token  (reset_password_token) UNIQUE
#

RSpec.describe CompaniesController, type: :controller do
  describe 'GET #index' do
    context 'no search params' do
      before :each do
        sign_in create(:admin)
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index.html.erb")
      end

      it 'assigns all the companies to @companies' do
        c1 = create(:company, name: "superhandyman")
        c2 = create(:company, name: "toiletsrus")
        c3 = create(:company, name: "ceilingrepairers")
        get :index
        expect(assigns(:companies)).to match_array [c1, c2, c3]
      end
    end

    context 'search params present' do
      before :each do
        sign_in create(:admin)
      end

      it 'assigns all the companies that match the query to @companies' do
        c1 = create(:company, name: "superhandyman")
        c2 = create(:company, name: "toiletsrus")
        c3 = create(:company, name: "ceilingrepairers")
        get :index, params: { query: "toiletsrus" }
        expect(assigns(:companies)).to eq([c2])
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index.html.erb")
      end
    end

    it 'redirects to root if no admin signed in' do
      get :index
      expect(response).to redirect_to('/')
    end
  end

  describe 'GET #show' do
    it 'assigns the requested company to @company' do
      company = create(:company)
      sign_in company
      get :show, params: { id: company.id }
      expect(assigns(:company)).to eq(company)
    end
    it 'renders show page' do
      company = create(:company)
      sign_in company
      get :show, params: { id: company.id }
      expect(response).to render_template("show.html.erb")
    end
    it 'redirects a user trying to access another users show page' do
      company1 = create(:company,
      email: "test@gmail.com", id: 20)
      company = create(:company,
      email: "example@gmail.com", id: 100)
      sign_in company
      get :show, params: { id: 20 }
      expect(response).to redirect_to("/")
    end
  end

  describe 'POST #create' do

  end

  describe 'GET #edit' do
    before :each do
      @company = create(:company)
      sign_in @company
    end
    it 'asigns the requested company to @company' do
      get :edit, params: { id: @company.id }
      expect(assigns(:company)).to eq(@company)
    end
    it 'renders edit page' do
      get :edit, params: { id: @company.id }
      expect(response).to render_template("edit.html.erb")
    end
  end

  describe 'PATCH #update' do
    it 'update the values of the company' do
      company = create(:company,
        name: "old value",
        phone: "1234"
      )
      sign_in company
      patch :update, params: {
        id: company.id,
        name: "New Value",
        phone: "5678"
       }
      company.reload
      expect(company.name).to eq("New Value")
      expect(company.phone).to eq("5678")
    end

    context 'with params[:status] && current_admin' do
      it 'updates the company status per the admin' do
        sign_in create(:admin)
        company = create(:company)
        patch :update, params: {
          id: company.id,
          status: "Active"
         }
        company.reload
        expect(company.status).to eq("Active")
      end
    end

    it 'redirect to the company page' do
      company = create(:company)
      sign_in company
      patch :update, params: { id: company.id }
      expect(response).to redirect_to("/companies/#{company.id}")
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @company = create(:company)
      sign_in @company
    end
    it 'removes the desired company from the database' do
      expect{
        delete :destroy, params: { id: @company.id }
      }.to change(Company, :count).by(-1)
    end
    it 'redirects to index page' do
      delete :destroy, params: { id: @company.id }
      expect(response).to redirect_to("index.html.erb")
    end
  end
end
