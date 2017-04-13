class ContractsController < ApplicationController

  def create
    @accepted_quote = Quote.find(params[:id])
    @customer_request = @accepted_quote.customer_request
    @accepted_quote.update(accepted: true)
    if Contract.create(
      quote_id: @accepted_quote.id,
      customer_request_id: @customer_request.id
    )
      @customer_request.quotes.each do |quote|
        if quote.accepted
          CompanyMailer.accept_email(quote).deliver_now
        else
          CompanyMailer.decline_email(quote).deliver_now
          @accepted_quote.update(accepted: false)
        end
      end
    else
      redirect_to "/quotes"
    end
  end

  def show
    @contract = Contract.find_by(params[:id])
    render "show.html.erb"
  end

end
