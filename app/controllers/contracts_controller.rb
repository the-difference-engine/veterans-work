class ContractsController < ApplicationController

  def create
    @accepted_quote = Quote.find_by(params[:id])
    @customer_request = accepted_quote.customer_request
    if Contract.create(
      @customer_request.quotes.each do |quote|
        if quote.accepted == true
          CompanyMailer.accept_email(quote).deliver_now
        else
          CompanyMailer.decline_email(quote).deliver_now
        end
      )
    else
      redirect_to "/quotes"
    end
end

  def show
    @contract = Contract.find_by(params[:id])
    render "show.html.erb"
  end

end
