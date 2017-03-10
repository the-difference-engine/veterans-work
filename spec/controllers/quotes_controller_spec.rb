require 'rails_helper'

RSpec.describe QuotesController, type: :controller do
  describe 'GET #new' do
    it 'renders a new form' do
      get :new
      expect(response).to render_template("new.html.erb")
    end
  end
  describe 'POST #create' do
    it 'creates a and saves a new customer quote to the database' do
      sign_in create(:company)
      expect{
        post :create, params: {
          quote: attributes_for(:quote)
        }
      }.to change(Quote, :count).by(1)
    end
  end


end
