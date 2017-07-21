require 'rails_helper'

RSpec.describe "the signin process", :type => :feature do
  before :each do
    create :company, email: 'user@example.com', password: 'password', status: 'Active'
  end

  it "signs me in" do
    visit '/companies/sign_in'
    within(".login-form") do
      fill_in 'company[email]', with: 'user@example.com'
      fill_in 'company[password]', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end
end