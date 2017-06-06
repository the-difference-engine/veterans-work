class CompanyMailer < ApplicationMailer
  def decline_email(quote)
    @quote = quote
    @company = quote.company
    mail(
      to: @company.email,
      subject: 'Your quote was declined by the customer.'
    )
  end

  def accept_email(quote)
    @quote = quote
    @company = quote.company
    mail(
      to: @company.email,
      subject: 'Your quote was accepted by the customer! Reply to continue'
    )
  end
end
