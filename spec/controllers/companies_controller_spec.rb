require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  describe 'GET #index' do
    it 'assigns all the companies to @companies' do
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
end
