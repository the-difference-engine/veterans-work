# == Schema Information
#
# Table name: credits
#
#  id         :integer          not null, primary key
#  cost       :decimal(, )
#  order_id   :integer
#  quote_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Credit < ApplicationRecord
  belongs_to :order

end
