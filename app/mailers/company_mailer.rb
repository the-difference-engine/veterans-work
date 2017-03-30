class CompanyMailer < ApplicationMailer
  default from: "no-reply@veteranswork.com"

  def decline_email(quote)
    @quote = params[:quote_id]
    @company = quote.company
    mail to: @company.email, subject: "Your quote was rejected by the customer"
  end
end
