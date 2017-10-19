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

class Company < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_query, :against => [
    :email,
    :name,
    :zip_code,
    :phone,
    :url,
    :address,
    :description,
    :city,
    :state,
    :status
  ]
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :company_services
  has_many :service_categories, through: :company_services
  has_many :reviews
  has_many :customers, through: :reviews
  has_many :quotes
  has_many :contracts, through: :quotes
  has_many :orders

  has_attached_file :avatar, 
    styles: { medium: '300x300>', thumb: '100x100>' }, 
    default_url: 'army.png'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :name, uniqueness: true
  validates :address, :city, :description, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :service_radius, presence: true, numericality: true
  validates :phone, presence: true,
                    numericality: true,
                    length: { is: 10 }
  validates_format_of :zip_code,
                   with: /\A\d{5}-\d{4}|\A\d{5}\z/,
                   message: 'should be 12345 or 12345-1234',
                   presence: true

  geocoded_by :full_street_address
  after_validation :geocode

  def shorten_zip_code
    zip_code[0..4]
  end

  def eligible_customer_requests
    CustomerRequest.where('expires_date >= ?', Date.today()).where(
      service_category_id: service_categories
    ).select {|cr| cr.distance_from([latitude, longitude]) <= service_radius }
  end

  def open_quotes
    quotes.where(accepted: nil)
  end

  def accepted_quotes
    quotes.where(accepted: true)
  end

  def star_avg
    if reviews.count > 0 
      stars = reviews.pluck(:stars)
      (stars.reduce(:+).to_f/stars.size).round
    else
      0.0
    end
  end

  def has_credit?
    credits > 0
  end

  private

  def full_street_address
    "#{address}, #{city}, #{state}, #{zip_code}"
  end
end
