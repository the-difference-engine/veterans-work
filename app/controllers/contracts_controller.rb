class ContractsController < ApplicationController

  def index
    contracts = []
    @active_contracts = []
    @completed_contracts = []
    if current_customer && current_customer.contracts.any?
      contracts = current_customer.contracts
    elsif current_company && current_company.contracts.any?
      contracts = current_company.contracts
    else
      redirect_to '/'
    end
    if contracts.any?
      @completed_contracts = contracts.select do |contract|
        contract.completion_date.present?
      end
      @active_contracts = contracts.select do |contract|
        contract.completion_date.nil?
      end
    end
  end

  def create
    accepted_quote = Quote.find(params[:contract][:quote_id])
    customer_request = accepted_quote.customer_request
    if current_customer.customer_requests.include?(customer_request)
      if Contract.create(
        quote_id: accepted_quote.id,
        customer_request_id: customer_request.id
      )
        if accepted_quote.update(accepted: true)
          customer_request.quotes.each do |quote|
            if quote.accepted
              CompanyMailer.accept_email(quote).deliver_now
            else
              begin
                CompanyMailer.decline_email(quote).deliver_now
              rescue => e
                Raven.capture_message(
                  'Failed to send declined quote email.',
                  extra: { error: e }
                )
              ensure
                quote.update(accepted: false)
              end
            end
          end
        end
      flash[:notice] = "Contract created and saved!"
      redirect_to '/quotes'
      else
        flash[:notice] = "Quote was not accepted. Try again. #{@quote.errors.full_messages.join(', ')}."
        redirect_to "/quotes/#{@quote.id}"
      end
    end
  end

  def show
    if current_customer || current_company
      @contract = Contract.find(params[:id])
      render 'show.html.erb'
    else
      redirect_to '/'
    end
  end
end
