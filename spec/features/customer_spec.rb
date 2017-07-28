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

RSpec.describe "customer accepts quote", :type => :feature do
  before :each do
    @company = create :company, email: 'user@example.com', password: 'password', status: 'Active', service_radius: 30.0, latitude: 41.9687556, longitude: -87.6939721
    @service_category = create :service_category, name: 'Paint'
    @company_service = create :company_service, service_category_id: @service_category.id, company_id: @company.id
    @customer = create :customer, email: 'customer@example.com', password: 'password'
    @customer_request = create :customer_request, customer_id: @customer.id, service_category_id: @service_category.id, zipcode: '60622', expires_date: Date.today() + 3, latitude: 41.9687556, longitude: -87.6939721
    @quote = create :quote, customer_request_id: @customer_request.id
    visit '/customers/sign_in'
    within(".login-form") do
      fill_in 'customer[email]', with: 'customer@example.com'
      fill_in 'customer[password]', with: 'password'
    end
    click_button 'Log in'
  end

  it 'customer accepts quote' do
    find(:css, 'ul.nav.navbar-nav.navbar-right').click_on('View Quotes')
    click_link 'Details'
    find(:css, 'input.btn.btn-md.btn-success').click
    expect(page).to have_content 'Contract created and saved!'
  end
end


