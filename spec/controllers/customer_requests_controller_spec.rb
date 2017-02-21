require 'rails_helper'

RSpec.describe CustomerRequestsController, type: :controller do
  describe 'GET #index' do
    it 'assigns all customer request to @requests' do
      all_requests = [
        create(:customer_request),
        create(:customer_request)
      ]
      get :index
      expect(assigns(:requests)).to eq(all_requests)
    end
    it 'renders the index html' do
      get :index
      expect(response).to render_template("index.html.erb")
    end
  end

  describe 'GET #new' do
    it '' do
    end
    it '' do
    end
  end

  describe 'POST #create' do
    it '' do
    end
    it '' do
    end
  end

  describe 'GET #show' do
    it '' do
    end
    it '' do
    end
  end

  describe 'GET #edit' do
    it '' do
    end
    it '' do
    end
  end

  describe 'PATCH #update' do
    it '' do
    end
    it '' do
    end
  end

  describe 'DELETE #destroy' do
    it '' do
    end
    it '' do
    end
  end
end
