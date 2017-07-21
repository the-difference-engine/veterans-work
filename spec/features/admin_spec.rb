require 'rails_helper'

RSpec.describe "the signin process", :type => :feature do
  before :each do
    create :admin, email: 'user@example.com', password: 'password'
  end

  it "signs me in" do
    visit '/admins/sign_in'
    within(".login-form") do
      fill_in 'admin[email]', with: 'user@example.com'
      fill_in 'admin[password]', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end
end 