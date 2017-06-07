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
#
# Indexes
#
#  index_companies_on_confirmation_token    (confirmation_token) UNIQUE
#  index_companies_on_email                 (email) UNIQUE
#  index_companies_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryGirl.define do
  factory :company do
    sequence(:email) {|n| "horatio_gomez#{n}@mailmail.com" }
    password "12345678"
    sequence(:name) {|n| "company #{n}"}
    confirmed_at Time.now
  end
end
