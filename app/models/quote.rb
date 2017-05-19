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
#

class Quote < ApplicationRecord
  belongs_to :company
  belongs_to :customer_request
  belongs_to :contract

  validates_uniqueness_of :company_id, scope: :customer_request_id

  def total_cost_estimate
    materials_cost_estimate + labor_cost_estimate
  end
end
