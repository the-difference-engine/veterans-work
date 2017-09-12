# == Schema Information
#
# Table name: companies
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  zip_code               :string
#  phone                  :string
#  description            :text
#  url                    :string
#  latitude               :float
#  longitude              :float
#  address                :string
#  city                   :string
#  state                  :string
#  service_radius         :float
#  status                 :string           default("Pending")
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  companies_file_name    :string
#  companies_content_type :string
#  companies_file_size    :integer
#  companies_updated_at   :datetime
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  credits                :integer          default(0)
#
# Indexes
#
#  index_companies_on_confirmation_token    (confirmation_token) UNIQUE
#  index_companies_on_email                 (email) UNIQUE
#  index_companies_on_reset_password_token  (reset_password_token) UNIQUE
#

COMPANY_ADDRESS_DETAILS = {
  address: "2515 W FLETCHER",
  city: "CHIACGO",
  state: "IL",
  zip_code: "60618"
}

CLOSE_CUSTOMER_REQUEST_ADDRESS_DETAILS = {
  address: "2600 W LAWRENCE",
  city: "CHICAGO",
  state: "IL",
  zipcode: "60625"
}

FAR_CUSTOMER_REQUEST_ADDRESS_DETAILS = {
  address: "14915 CHARLEVOIX ST",
  city: "DETROIT",
  state: "MI",
  zipcode: "48230"
}

RSpec.describe Company, type: :model do

  describe "validations" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:company)).to be_valid
    end
  end

  describe "#shorten_zip_code" do
    it "returns the first 5 characters of a zip_code" do
      company = build(:company, zip_code: "12345-6789")
      expect(company.shorten_zip_code).to eq("12345")
    end
  end

  describe "#eligible_customer_requests" do
    it "doesn't return expired customer requests" do
      service_category = create(:service_category)
      company = create(:company,
        COMPANY_ADDRESS_DETAILS.merge({service_radius: 50.0})
      )
      company_service = create(:company_service,
        company_id: company.id,
        service_category_id: service_category.id
      )
      expired_customer_request = create(:customer_request,
        CLOSE_CUSTOMER_REQUEST_ADDRESS_DETAILS.merge({
          service_category_id: service_category.id,
          expires_date: Date.today() - 1
        })
      )
      expect(company.eligible_customer_requests).to_not include(expired_customer_request)
    end

    it "returns ONLY customer requests that are in the service radius" do
      service_category = create(:service_category)
      company = create(:company,
        COMPANY_ADDRESS_DETAILS.merge({service_radius: 50.0})
      )
      company_service = create(:company_service,
        company_id: company.id,
        service_category_id: service_category.id
      )
      close_customer_request = create(:customer_request,
        CLOSE_CUSTOMER_REQUEST_ADDRESS_DETAILS.merge({ service_category_id: service_category.id })
      )
      far_customer_request = create(:customer_request,
        FAR_CUSTOMER_REQUEST_ADDRESS_DETAILS.merge({ service_category_id: service_category.id })
      )
      expect(company.eligible_customer_requests).to eq([close_customer_request])
    end
  end
end
