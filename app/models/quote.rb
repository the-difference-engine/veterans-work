# == Schema Information
#
# Table name: quotes
#
#  id                       :integer          not null, primary key
#  customer_request_id      :integer
#  company_id               :integer
#  materials_cost_estimate  :decimal(, )
#  labor_cost_estimate      :decimal(, )
#  start_date               :date
#  completion_date_estimate :date
#  notes                    :text
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  accepted                 :boolean
#  customer_viewed          :boolean          default(FALSE)
#

class Quote < ApplicationRecord
  belongs_to :company
  belongs_to :customer_request

  has_many :contracts

  validates_uniqueness_of :company_id, scope: :customer_request_id
  validates :materials_cost_estimate, presence: true
  validates :labor_cost_estimate, presence: true
  validates :completion_date_estimate, presence: true
  validates :start_date, presence: true
  validates :notes, presence: true

  def total_cost_estimate
    materials_cost_estimate + labor_cost_estimate
  end
end
