class CompanyMailerPreview < ActionMailer::Preview
  def decline_email_preview
    # quote = Quote.last
    CompanyMailer.decline_email(Quote.last)
  end

  def accept_email_preview
    # quote = Quote.last
    CompanyMailer.accept_email(Quote.last)
  end
end