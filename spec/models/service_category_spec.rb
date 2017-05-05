# == Schema Information
#
# Table name: service_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

RSpec.describe ServiceCategory, type: :model do
    it 'has a valid factory' do
      expect(build(:service_category)).to be_valid
    end
end
