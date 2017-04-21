# == Schema Information
#
# Table name: quotes
#
#  id                       :integer          not null, primary key
#  customer_request_id      :integer
#  company_id               :integer
#  materials_cost_estimate  :decimal(, )      default("0")
#  labor_cost_estimate      :decimal(, )      default("0")
#  start_date               :date
#  completion_date_estimate :date
#  notes                    :text
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  accepted                 :boolean
#

require 'rails_helper'

RSpec.describe Quote, type: :model do
  describe "#total_cost_estimate" do
    it "returns the sum of the materials_cost_estimate and the labor_cost_estimate" do
      quote = build(:quote, materials_cost_estimate: 10.0, labor_cost_estimate: 10.0)
      expect(quote.total_cost_estimate).to eq(20.0)
    end
  end
end
