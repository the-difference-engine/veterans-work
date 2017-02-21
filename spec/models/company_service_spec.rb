require 'rails_helper'

RSpec.describe CompanyService, type: :model do
  it 'creates a category' do
    p create(:company_service)
  end
end
