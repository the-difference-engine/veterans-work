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

RSpec.describe Review, type: :model do
  describe "validations" do
    it 'has a valid factory' do
      expect(build(:review)).to be_valid
    end

    it "is invalid with a customer rating less than one and greater than 5" do
      expect(build(:review, stars: 6)).to_not be_valid
      expect(build(:review, stars: 0)).to_not be_valid
    end

    it "is invalid without a customer_id" do
      review = build(:review, customer_id: nil)
      review.valid?
      expect(review.errors[:customer_id]).to include("can't be blank")
    end

    it "is invalid without a company_id" do
      review = build(:review, company_id: nil)
      review.valid?
      expect(review.errors[:company_id]).to include("can't be blank")
    end

    it "is invalid if the body is greater than 2500" do
      review = build(:review, body: Faker::Lorem.characters(2505))
      review.valid?
      expect(review.errors[:body]).to include("is too long (maximum is 2500 characters)")
    end

      it "is invalid without stars" do
      review = build(:review, stars: nil)
      review.valid?
      expect(review.errors[:stars]).to include("can't be blank")
    end
  end
end
