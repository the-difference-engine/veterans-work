require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  describe 'GET #index' do
    it 'assigns all the companies to @companies' do
      this_company = create(:company)
      that_company = create(:company)
      another_company = create(:company)
      get :index
      expect(assigns(:companies)).to eq([this_company, that_company, another_company])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index.html.erb")
    end
  end
end
