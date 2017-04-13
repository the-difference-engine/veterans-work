require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  describe 'GET #index' do
    context 'no search params' do
      it 'assigns all the companies to @companies' do
        c1 = create(:company)
        c2 = create(:company)
        c3 = create(:company)
        get :index
        expect(assigns(:companies)).to eq([c1, c2, c3])
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index.html.erb")
      end
    end

    context 'search params present' do
      it 'assigns all the companies that match the query to @companies' do
        c1 = create(:company, name: "fgsefe")
        c2 = create(:company, name: "asdffgsefefdsa")
        c3 = create(:company)
        get :index, params: { query: "fgsefe" }
        expect(assigns(:companies)).to eq([c1, c2])
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index.html.erb")
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested company to @company' do
      company = create(:company)
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
      expect(:company).to redirect_to("/")
    end
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
