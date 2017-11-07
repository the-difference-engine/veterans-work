require 'rails_helper'

RSpec.describe 'Clicking navbar links', :type => :feature do

  it 'goes to the homepage' do
    visit '/about'
    find_link('Home').click
    expect(page).to have_content 'Connect Customers in Need with Veterans in Skilled Trades'
  end

  it 'goes to the how page' do
    visit '/'
    find_link('How').click
    expect(page).to have_content 'How it Works'
  end

  it 'goes to the about page' do
    visit '/'
    find_link('About').click
    expect(page).to have_content 'For our beloved veterans in the skilled trades,'
  end

  it 'goes to the Customer Sign-up page' do
    visit '/'
    page.find('#customer-sign-up').click
    expect(page).to have_content 'Customer Registration'
  end

  it 'goes to the Customer Sign-in page' do
    visit '/'
    page.find('#customer-sign-in').click
    expect(page).to have_content 'Customer Sign In'
  end
end

RSpec.describe "Clicking content links on splash page", :type => :feature do

  it 'goes to the Company Sign-in page' do
    visit '/'
    page.find('#company-sign-in').click
    expect(page).to have_content 'Company Sign In'
  end

  it 'goes to the Company Sign-up page' do
    visit '/'
    page.find('#company-sign-up').click
    expect(page).to have_content 'Company Registration'
  end

end