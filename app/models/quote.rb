# == Schema Information
#
# Table name: quotes
#
#  id                       :integer          not null, primary key
#  customer_request_id      :integer
#  company_id               :integer
#  materials_cost_estimate  :decimal(, )      default("0")
#  labor_cost_estimate      :decimal(, )      default("0")
#  start_date               :date
#  completion_date_estimate :date
#  notes                    :text
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  accepted                 :boolean
#

class Quote < ApplicationRecord
  belongs_to :company
  belongs_to :customer_request
  belongs_to :contract
  has_many :customer_requests, through: :contracts

  def total_cost_estimate
    materials_cost_estimate + labor_cost_estimate
  end

end
