require 'rails_helper'

RSpec.describe ServiceCategory, type: :model do
  it 'creates a categoy' do
    p create(:service_category)
  end
end
