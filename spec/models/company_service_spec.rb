# == Schema Information
#
# Table name: company_services
#
#  id                  :integer          not null, primary key
#  company_id          :integer
#  service_category_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe CompanyService, type: :model do

end
