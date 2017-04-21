class QuotesController < ApplicationController

  def index
    if current_customer
      @customer_requests = current_customer.customer_requests
    elsif current_company
      @quotes = current_company.quotes
    else
      redirect_to "/"
    end
  end

  def new
    @quote = Quote.new
    @quote.customer_request_id = params[:customer_request_id]
    render "new.html.erb"
  end

  def create
    quote = Quote.new(quote_params)
    sanitize_blank_costs(quote)
    quote.save
    redirect_to '/customer_requests'
  end

  def show
    @quote = Quote.find(params[:id])
    @customer_request = @quote.customer_request
    @company = @quote.company
  end

  private

  def quote_params
    params.require(:quote).permit(
      :customer_request_id,
      :materials_cost_estimate,
      :labor_cost_estimate,
      :start_date,
      :completion_date_estimate,
      :notes
    ).merge(
      company_id: current_company.id,
      customer_request_id: params[:customer_request_id]
    )
  end

  def sanitize_blank_costs(quote)
    Quote.columns_hash.each do |key, value|
      if value.type == :decimal
        if quote[key] == nil || quote[key] == ''
          quote[key] = 0
        end
      end
    end
  end
end
