# == Schema Information
#
# Table name: customers
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
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#
# Indexes
#
#  index_customers_on_confirmation_token    (confirmation_token) UNIQUE
#  index_customers_on_email                 (email) UNIQUE
#  index_customers_on_reset_password_token  (reset_password_token) UNIQUE
#

class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :reviews, dependent: :delete_all
  has_many :companies, through: :reviews
  has_many :customer_requests, dependent: :delete_all
  has_many :quotes, through: :customer_requests
  has_many :contracts, through: :customer_requests

  def open_quotes
    quotes.where(accepted: nil)
  end

  def accepted_quotes
    quotes.joins(:contracts).where(
      'quotes.accepted IS true AND contracts.completion_date IS null'
    )
  end

  def declined_quotes
    quotes.where(accepted: false)
  end

  def completed_quotes
    quotes.joins(:contracts).where(
      'quotes.accepted IS true AND contracts.completion_date IS NOT null'
    )
  end
end
