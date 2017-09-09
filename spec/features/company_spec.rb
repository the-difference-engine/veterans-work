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


RSpec.describe 'company creates quote', :type => :feature do
  before :each do
    @company = create :company, email: 'user@example.com', password: 'password', status: 'Active', service_radius: 30.0, latitude: 41.9687556, longitude: -87.6939721
    @order = create :order, company_id: @company.id
    @credit = create :credit, order_id: @order.id
    @service_category = create :service_category, name: 'Paint'
    @company_service = create :company_service, service_category_id: @service_category.id, company_id: @company.id
    @customer = create :customer, email: 'customer@example.com', password: 'password'
    @customer_request = create :customer_request, customer_id: @customer.id, service_category_id: @service_category.id, zipcode: '60622', expires_date: Date.today() + 3, latitude: 41.9687556, longitude: -87.6939721
    visit '/companies/sign_in'
    within(".login-form") do
      fill_in 'company[email]', with: 'user@example.com'
      fill_in 'company[password]', with: 'password'
    end
    click_button 'Log in'
  end

  it 'company creates quote' do
    find('td:first-child').click_link
    click_link 'New Quote'
    fill_in 'quote[materials_cost_estimate]', with: '100'
    fill_in 'quote[labor_cost_estimate]', with: '100'
    fill_in 'quote[start_date]', with: Date.today()
    fill_in 'quote[completion_date_estimate]', with: Date.today() + 2
    fill_in 'quote[notes]', with: 'How about them apples!'
    click_button 'Submit'
    expect(page).to have_content 'New Quote created successfully!'
  end
end




