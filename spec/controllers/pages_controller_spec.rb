require 'rails_helper'
require 'spec_helper'

RSpec.describe PagesController, type: :controller do

  describe "#assert" do
    it 'should return true' do
      expect(true).to eq(true)
    end
  end

end
