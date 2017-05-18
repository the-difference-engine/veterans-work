# == Schema Information
#
# Table name: customer_requests
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  address             :string
#  city                :string
#  state               :string
#  zipcode             :string
#  service_category_id :integer
#  description         :text
#  customer_id         :integer
#  expires_date        :date
#  latitude            :float
#  longitude           :float
#
# Indexes
#
#  index_customer_requests_on_expires_date  (expires_date)
#

class CustomerRequest < ApplicationRecord
  belongs_to :service_category
  belongs_to :customer
  belongs_to :contract

  has_many :quotes

  geocoded_by :full_street_address
  after_validation :geocode

  def full_street_address
    "#{address}, #{city}, #{state}, #{zipcode}"
  end

  def open_quotes
    quotes.where(accepted: nil)
  end

  def accepted_quotes
    quotes.where(accepted: true)
  end
end
