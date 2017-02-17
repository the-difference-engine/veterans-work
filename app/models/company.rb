class Company < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :company_services
  has_many :service_categories, through: :company_services

  def shorten_zip_code
    zip_code[0..4]
  end
  def eligible_customer_requests
  end
end