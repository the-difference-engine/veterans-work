require 'sendgrid-ruby'
include SendGrid
require 'json'

class CompanyMailer < ApplicationMailer
  helper MailerHelper
  
  def decline_email(quote)
    @quote = quote
    @company = quote.company

    mail to: mail.to,
         subject: mail.subject
  end

  def accept_email(quote)
    @quote = quote
    @company = quote.company

    mail to: @company.email,
         subject: 'Your quote was accepted by the customer! Reply to continue'
  end

  def welcome_email(company)
    @company = company
    @company_email = @company.email
    mail.welcome_mailer_params
  end
end
