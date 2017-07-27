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
