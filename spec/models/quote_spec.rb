# == Schema Information
#
# Table name: quotes
#
#  id                       :integer          not null, primary key
#  customer_request_id      :integer
#  company_id               :integer
#  materials_cost_estimate  :decimal(, )
#  labor_cost_estimate      :decimal(, )
#  start_date               :date
#  completion_date_estimate :date
#  notes                    :text
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  accepted                 :boolean
#  customer_viewed          :boolean          default(FALSE)
#  view_date                :date
#

RSpec.describe Quote, type: :model do
  describe "validations" do
    it 'has a valid factory' do
      expect(build(:quote)).to be_valid
    end

    it "is invalid if company already has quote for customer request" do
      customer_request = create(:customer_request)
      company = create(:company)
      quote1 = create(:quote,
        customer_request_id: customer_request.id,
        company_id: company.id
      )
      quote2 = build(:quote,
        customer_request_id: customer_request.id,
        company_id: company.id
      )
      expect(quote2).to_not be_valid
    end

    it "is valid if company doesn't have quote for customer request" do
      customer_request = create(:customer_request)
      company = create(:company)
      quote = build(:quote,
        customer_request_id: customer_request.id,
        company_id: company.id
      )
      expect(quote).to be_valid
    end
  end

  describe "#total_cost_estimate" do
    it "returns the sum of the materials_cost_estimate and the labor_cost_estimate" do
      quote = build(:quote, materials_cost_estimate: 10.0, labor_cost_estimate: 10.0)
      expect(quote.total_cost_estimate).to eq(20.0)
    end
  end
end
