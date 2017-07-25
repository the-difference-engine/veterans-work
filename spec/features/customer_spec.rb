require 'rails_helper'

RSpec.describe "the signout process", :type => :feature do
  before :each do
    @customer = create :customer, email: 'customer@example.com', password: 'password'
    visit '/customers/sign_in'
    within(".login-form") do
      fill_in 'customer[email]', with: 'customer@example.com'       
      fill_in 'customer[password]', with: 'password'
    end
    click_button 'Log in'
  end

  it 'signs me out' do
    visit "/customers/#{@customer.id}"
    find(:css, 'ul.nav.navbar-nav.navbar-right').click_on("Logout #{@customer.email}")
    expect(page).to have_content 'Signed out successfully'
  end
end
