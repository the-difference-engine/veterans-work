class ContractsController < ApplicationController

  def create
    accepted_quote = Quote.find(params[:id])
    customer_request = accepted_quote.customer_request
    if current_customer.customer_requests.include?(customer_request)
      if Contract.create(
        quote_id: accepted_quote.id,
        customer_request_id: customer_request.id
      )
        customer_request.quotes.each do |quote|
          if quote.accepted
            CompanyMailer.accept_email(quote).deliver_now
          else
            CompanyMailer.decline_email(quote).deliver_now
            accepted_quote.update(accepted: false)
          end
        end
      else
        redirect_to "/quotes"
      end
    end
  end

  def show
    @contract = Contract.find(params[:id])
    if current_customer || current_company
      render "show.html.erb"
    else
      redirect_to '/'
    end
  end

end
