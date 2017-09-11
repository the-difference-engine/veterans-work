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
#  credits                :integer
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
    phone "1234567890"
    confirmed_at Time.now
    address Faker::Address.street_address
    city Faker::Address.city
    state Faker::Address.state_abbr
    zip_code Faker::Address.zip_code
    url Faker::Internet.url('example.com', '/foobar.html')
    service_radius 35
    description Faker::Lorem.paragraph
    credits 10
  end

  trait :without_credits do
    credits 0
  end
end
