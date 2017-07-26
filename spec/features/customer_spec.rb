require 'rails_helper'

RSpec.describe "the signin process", :type => :feature do
  before :each do
    create :customer, email: 'user@example.com', password: 'password'
  end

  it "signs me in" do
    visit '/customers/sign_in'
    within('.login-form') do
      fill_in 'customer[email]', with: 'user@example.com'
      fill_in 'customer[password]', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
