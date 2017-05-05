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

RSpec.describe CompanyService, type: :model do
  describe '#validations' do
    it 'has a valid factory' do
      expect(build(:company_service)).to be_valid
    end
  end
end
