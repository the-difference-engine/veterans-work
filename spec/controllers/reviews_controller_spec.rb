# == Schema Information
#
# Table name: reviews
#
#  id          :integer          not null, primary key
#  customer_id :integer
#  company_id  :integer
#  stars       :integer
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

RSpec.describe ReviewsController, type: :controller do
  describe 'GET #index' do
    it 'assigns all the reviews to @reviews' do
      review1 = create(:review)
      review2 = create(:review)
      review3 = create(:review)
      get :index
      expect(assigns(:reviews)).to eq([review1, review2, review3])
    end
  end

  describe 'GET #new' do
    it 'assigns a new instance of review to @review' do
      sign_in create(:customer)
      company = create(:company)
      get :new
      expect(assigns(:review)).to be_a_new(Review)
    end
  end

  describe 'POST #create' do
    it 'saves the new review to the database' do
      sign_in create(:customer)
      company = create(:company)
      expect{
        post :create, params: {
          company_id: company.id,
          stars: 3,
          body: 'yo yo yo'
        }
      }.to change(Review, :count).by(1)
    end
  end

  describe '' do
  end

  describe '' do
  end

  describe '' do
  end
end
