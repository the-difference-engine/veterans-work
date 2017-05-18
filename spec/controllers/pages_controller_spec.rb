RSpec.describe PagesController, type: :controller do
  describe "GET #index" do
    context "with an active company session" do
      it "redirects to the customer requests index page" do
        company = create :company
        sign_in company
        get :index
        expect(response).to redirect_to("/customer_requests")
      end
    end

    context "with an active customer session" do
      it "redirects to the customer's show page" do
        customer = create :customer
        sign_in customer
        get :index
        expect(response).to redirect_to("/customers/#{customer.id}")
      end
    end

    context "with an active customer session" do
      it "redirects to the customer's show page" do
        admin = create :admin
        sign_in admin
        get :index
        expect(response).to redirect_to("/admins")
      end
    end

    context "without an active session" do
      it "renders the main index page" do
        get :index
        expect(response).to render_template("index.html.erb")
      end
    end
  end

  describe "GET #about" do
    it "renders the about page" do
      get :about
      expect(response).to render_template("about.html")
    end
  end
end
