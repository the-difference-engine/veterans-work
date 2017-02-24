require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  describe 'GET #index' do
    xit 'assigns all the companies to @companies' do
      all_companies = [
        create(:company),
        create(:company),
        create(:company),
      ]
      get :index
      expect(assigns(:companies)).to eq(all_companies)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index.html.erb")
    end
  end

  describe 'GET #show' do
    it 'assigns the requested company to @sompany' do
      company = create(:company)
      get(:show, id: company.id)
      expect(assigns(:company)).to eq(company)
    end
    it 'renders show page' do
      company = create(:company)
      get(:show, id: company.id)
      expect(response).to render_template("show.html.erb")
    end
  end

  describe 'GET #edit' do
    before :each do
      @company = create(:company)
    end
    it 'asigns the requested company to @company' do
      get(:edit, id: @company.id)
      expect(assigns(:company)).to eq(@company)
    end
    it 'renders edit page' do
      get(:edit, id: @company.id)
      expect(response).to render_template("edit.html.erb")
    end
  end

  describe 'PATCH #update' do    
    it 'update the values of the company' do
      company = create(:company, 
        name: "old value", 
        phone: "1234"
      )
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
      patch(:update, id: company.id)
      expect(response).to redirect_to("/companies/#{company.id}")
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @company = create(:company)
    end
    it 'removes the desired company from the database' do
      company_count = Company.count
      delete(:destroy, id: @company.id)
      expect(Company.count).to eq(company_count - 1)
    end
    it 'redirects to index page' do
      delete(:destroy, id: @company.id)
      expect(response).to redirect_to("index.html.erb")
    end
  end
end



