class QuoteMailer < ApplicationMailer
  default from: 'noreply@veteranswork.com'

  def email_quote(quote)
    @quote = quote
    @email_address = quote.customer_request.customer.email
    mail(to: @email_address, subject: 'Your requested quote', body: @quote)
  end
end
