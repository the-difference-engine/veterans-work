require 'rails_helper'

RSpec.describe 'Clicking navbar links', :type => :feature do

  it 'goes to the homepage' do
    visit '/about'
    within('.navbar') do
      find_link('Home').click
    end
    expect(page).to have_content 'Connect Customers with Veterans in Skilled Trades'
  end

  it 'goes to the how page' do
    visit '/'
    within('.navbar') do
      find_link('How').click
    end
    expect(page).to have_content 'How it Works'
  end

  it 'goes to the about page' do
    visit '/'
    within('.navbar') do
      find_link('About').click
    end
    expect(page).to have_content 'For our beloved veterans in the skilled trades,'
  end

  it 'goes to the Customer Sign-up page' do
    visit '/'
    within('.navbar') do
      page.find('#customer-sign-up').click
    end
    expect(page).to have_content 'Customer Registration'
  end

  it 'goes to the Customer Sign-in page' do
    visit '/'
    within('.navbar') do
      page.find('#customer-sign-in').click
    end
    expect(page).to have_content 'Customer Sign In'
  end

  it 'goes to the Company Sign-in page' do
    visit '/'
    within('.navbar') do
      page.find('#company-sign-in').click
    end
    expect(page).to have_content 'Company Sign In'
  end

  it 'goes to the Company Sign-up page' do
    visit '/'
    within('.navbar') do
      page.find('#company-sign-up').click
    end
    expect(page).to have_content 'Company Registration'
  end
end

RSpec.describe "Clicking call-to-action links on splash page", :type => :feature do

  it 'goes to the Company Sign-in page' do
    visit '/'
    within(".company-cta") do
      find_link('Veterans Sign-In').click
    end
    expect(page).to have_content 'Company Sign In'
  end

  it 'goes to the Company Sign-up page' do
    visit '/'
    within(".company-cta") do
      find_link("Sign-Up").click
    end
    expect(page).to have_content 'Company Registration'
  end

  it 'goes to the Customers Sign-in page' do
    visit '/'
    within(".customer-cta") do
      find_link('Customers Sign-In').click
    end
    expect(page).to have_content 'Customer Sign In'
  end

  it 'goes to the Customers Sign-up page' do
    visit '/'
    within(".customer-cta") do
      find_link("Sign-Up").click
    end
    expect(page).to have_content 'Customer Registration'
  end

  it 'goes to the How It Works page' do
    visit '/'
    within(".learn-cta") do
      find_link('Learn More').click
    end
    within('#how') do
      expect(page).to have_content 'How it Works'
    end
  end

  it 'goes to the About page' do
    visit '/'
    within('.home-about') do
      find_link('Read More. . .').click
    end
    within('#about') do
      expect(page).to have_content 'Our Mission'
    end
  end
end


RSpec.describe "Clicking links on How page", :type => :feature do

  it 'goes to the Customer Sign up page' do
    visit '/how'
    page.find('#first div.text span span.centered-link a').click
    expect(page).to have_content 'Customer Registration'
  end

  it 'goes to the Customer Log in page' do
    visit '/how'
    page.find('#second div.text span span.centered-link a').click
    expect(page).to have_content 'Customer Sign In'
  end

  it 'goes to the Customer Request page' do
    with_customer_signed_in
    visit '/how'
    page.find('#second div.text span span.centered-link a').click
    expect(page).to have_content 'Enter Work Request'
  end

  it 'goes to the Customer Registration' do
    visit '/how'
    page.find('#fifth div.text span span.centered-link a').click
    expect(page).to have_content 'Customer Registration'
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