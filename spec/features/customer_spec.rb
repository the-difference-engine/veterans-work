require 'rails_helper'

RSpec.describe 'the signout process', :type => :feature do
  it 'signs me out' do
    with_customer_signed_in
    visit "/customers/#{@customer.id}"
    find(:css, 'ul.nav.navbar-nav.navbar-right').click_on("Logout #{@customer.email}")
    expect(page).to have_content 'Signed out successfully'
  end
end

RSpec.describe 'the signin process', :type => :feature do
  it 'signs me in' do
    with_customer_signed_in
    expect(page).to have_content 'Signed in successfully.'
  end
end

RSpec.describe 'the work request creation process', :type => :feature do
  it 'directs to new work request form' do
    create :service_category, name: 'paint'
    with_customer_signed_in
    find_link('New Work Request').click()
    expect(page).to have_content 'Enter Work Request'
    within('#new_customer_request') do
      fill_in 'customer_request[address]', with: '301 N Michigan Ave'
      fill_in 'customer_request[city]', with: 'Chicago'
      fill_in 'customer_request[state]', with: 'IL'
      fill_in 'customer_request[zipcode]', with: '60601'
      fill_in 'customer_request[description]', with: 'abc'
      fill_in 'customer_request[expires_date]', with: Date.today + 1
      select('paint', from: 'customer_request[service_category_id]')
      click_button 'Submit'
    end
    expect(page).to have_content 'My Work Requests'
  end
end

def with_customer_signed_in
  @customer = create :customer, email: 'customer@example.com', password: 'password'
  visit '/customers/sign_in'
  within('.login-form') do
    fill_in 'customer[email]', with: 'customer@example.com'
    fill_in 'customer[password]', with: 'password'
  end
  click_button 'Log in'
end

RSpec.describe "customer decides on quote", :type => :feature do
  before :each do
    @company = create :company, email: 'user@example.com', password: 'password', status: 'Active', service_radius: 30.0, latitude: 41.9687556, longitude: -87.6939721
    @service_category = create :service_category, name: 'Paint'
    @company_service = create :company_service, service_category_id: @service_category.id, company_id: @company.id
    @customer = create :customer, email: 'customer@example.com', password: 'password'
    @customer_request = create :customer_request, customer_id: @customer.id, service_category_id: @service_category.id, zipcode: '60601', expires_date: Date.today() + 3, latitude: 41.9687556, longitude: -87.6939721
    @quote = create :quote, customer_request_id: @customer_request.id
    visit '/customers/sign_in'
    within(".login-form") do
      fill_in 'customer[email]', with: 'customer@example.com'
      fill_in 'customer[password]', with: 'password'
    end
    click_button 'Log in'
  end

  it 'customer rejects quote' do
    first(:css, 'ul.nav.navbar-nav.navbar-right').click_on('View Quotes')
    click_link 'Details'
    click_button "Decline Quote"
    click_button "Yes"
    expect(@company.quotes.length).to eq(0)
  end

  it 'customer accepts quote' do
    find(:css, 'ul.nav.navbar-nav.navbar-right').click_on('View Quotes')
    click_link 'Details'
    first(:css, 'input.btn.btn-md.btn-success').click
    expect(page).to have_content 'Contract created and saved!'
  end

  context 'customer view of quotes table for open quotes' do
    before :each do
      @customer_request.update(description: 'Sample request description')
      visit('/quotes')
    end

    it 'should show open quotes in open quote table' do
      within '#open_quotes' do
        expect(page).to have_content('Sample request description')
      end
    end
    it 'should not show open quotes in accepted quote table' do
      within '#accepted_quotes' do
        expect(page).to_not have_content('Sample request description')
      end
    end
  end

  context 'customer view of quotes table for accepted quotes' do
    before :each do
      @customer_request.update(description: 'Sample request description')
      @quote.update(accepted: true)
      visit('/quotes')
    end

    it 'should not show accepted quotes in open quote table' do
      within '#open_quotes' do
        expect(page).to_not have_content('Sample request description')
      end
    end
    it 'should show accepted quotes in accepted quote table' do
      within '#accepted_quotes' do
        expect(page).to have_content('Sample request description')
      end
    end
  end
end
