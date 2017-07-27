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

RSpec.describe "the signout process", :type => :feature do
  before :each do
    @company = create :company, email: 'company@example.com', password: 'password', status: 'Active'
    visit '/companies/sign_in'
    within(".login-form") do
      fill_in 'company[email]', with: 'company@example.com'
      fill_in 'company[password]', with: 'password'
    end
    click_button 'Log in'
  end

  it 'signs me out' do
    visit '/customer_requests'
    find(:css, 'ul.nav.navbar-nav.navbar-right').click_on("Logout #{@company.name}")
    expect(page).to have_content 'Signed out successfully'
  end
end
