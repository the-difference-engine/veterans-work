require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "#shorten_zip_code" do
    it 'returns the first 5 characters of a zip_code' do
      company = build(:company, zip_code: "12345-6789")
      expect(company.shorten_zip_code).to eq("12345")
    end
  end
end
