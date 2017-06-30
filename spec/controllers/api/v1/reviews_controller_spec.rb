require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:ok)
    end
  end

end
