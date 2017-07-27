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

RSpec.describe "the signout process", :type => :feature do
  before :each do
    @admin = create :admin, email: 'user@example.com', password: 'password'
    visit '/admins/sign_in'
    within(".login-form") do
      fill_in 'admin[email]', with: 'user@example.com'
      fill_in 'admin[password]', with: 'password'
    end
    click_button 'Log in'
  end

  it 'signs me out' do
    visit '/admins'
    find(:css, 'ul.nav.navbar-nav.navbar-right').click_on("Logout #{@admin.email}")
    expect(page).to have_content 'Signed out successfully'
  end
end