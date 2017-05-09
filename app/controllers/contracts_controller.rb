class ContractsController < ApplicationController

  def create
    accepted_quote = Quote.find(params[:quote_id])
    customer_request = accepted_quote.customer_request
    if current_customer.customer_requests.include?(customer_request)
      if Contract.create(
        quote_id: accepted_quote.id,
        customer_request_id: customer_request.id
      )
        if has_fewer_than_3_siblings?(customer_request)
          if accepted_quote.update(accepted: true)
            customer_request.quotes.each do |quote|
              if quote.accepted
                CompanyMailer.accept_email(quote).deliver_now
              else
                CompanyMailer.decline_email(quote).deliver_now
                quote.update(accepted: false)
              end
            end
          end
        end
      else
        redirect_to "/quotes"
      end
    end
  end

  def show
    if current_customer || current_company
      @contract = Contract.find(params[:id])
      render "show.html.erb"
    else
      redirect_to '/'
    end
  end

  private

  def has_fewer_than_3_siblings?(customer_request)
    if customer_request.quotes.count <= 3
      return true
    end
  end

end
