# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  company_id :integer
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ApplicationRecord

  CREDIT_COST = ENV['CREDIT_COST'].to_f

  belongs_to :company

end
