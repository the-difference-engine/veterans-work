class CompanyMailerPreview < ActionMailer::Preview
  def decline_email_preview
    quote = Quote.last
    CompanyMailer.decline_email(quote)
  end

  def accept_email_preview
    quote = Quote.last
    CompanyMailer.accept_email(quote)
  end
end