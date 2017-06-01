require 'sendgrid-ruby'
include SendGrid
require 'json'

class CustomerMailer < ApplicationMailer
  helper MailerHelper

  def welcome_email(customer)
    @customer = customer
    @customer_email = @customer.email
    mail.welcome_mailer_params
  end

end