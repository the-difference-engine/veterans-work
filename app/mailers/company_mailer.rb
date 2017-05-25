require 'sendgrid-ruby'
include SendGrid
require 'json'

class CompanyMailer < ApplicationMailer
  
  def decline_email(quote)
    @quote = quote
    @company = quote.company

    mail to: @company.email,
         subject: 'Your quote was rejected by the customer.'
    mail to: @company.email,
         subject: "Your quote was rejected by the customer"
  end

  def accept_email(quote)
    @quote = quote
    @company = quote.company

    mail to: @company.email,
         subject: 'Your quote was accepted by the customer! Reply to continue'
  end

  def welcome_email
    from = Email.new(email: 'noreply@veteranswork.com')
    subject = 'Hello World from the SendGrid Ruby Library'
    to = Email.new(email: 'veteransworkheroku@gmail.com')
    content = Content.new(type: 'text/plain', value: 'Welcome to Veterans Work! Your account will be evaluated before being activated!')
    mail = Mail.new(from, subject, to, content)
    # puts JSON.pretty_generate(mail.to_json)
    puts mail.to_json

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com')
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
end
