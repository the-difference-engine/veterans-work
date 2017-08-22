# == Schema Information
#
# Table name: reviews
#
#  id          :integer          not null, primary key
#  customer_id :integer
#  company_id  :integer
#  stars       :integer
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Review < ApplicationRecord
  validates :customer_id, presence: true
  validates :company_id, presence: true
  validates :stars, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }
  validates :body, length: { maximum: 2500 }
  validates :stars, presence: true

  belongs_to :customer
  belongs_to :company


end
