class Company < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :company_services
  has_many :service_categories, through: :company_services
  has_many :reviews
  has_many :customers, through: :reviews
  has_many :quotes

  geocoded_by :full_street_address
  after_validation :geocode

  def shorten_zip_code
    zip_code[0..4]
  end

  def eligible_customer_requests
    CustomerRequest.where("expires_date >= ?", Date.today()).where(
      service_category_id: service_categories
    ).select {|cr| cr.distance_from([latitude, longitude]) <= service_radius }
  end

  private

  def full_street_address
    "#{address}, #{city}, #{state}, #{zip_code}"
  end

end
