require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :controller do

  describe "GET #create" do
    it "returns http success if review saves properly" do
      get :create, params: {body: "test", company_id: 3, customer_id: 1, stars: 3}
      expect(response).to have_http_status(200)
    end

    it "returns 404 if review does not save properly" do
      get :create, params: {body: "test", company_id: 3, customer_id: 1, stars: 10}
      expect(response).to have_http_status(404)
    end
  end

end
