class QuotesController < ApplicationController

  def index
    if current_customer
      @customer_requests = current_customer.customer_requests
      @open_quotes = current_customer.open_quotes
      @accepted_quotes = current_customer.accepted_quotes
    elsif current_company
      @open_quotes = current_company.open_quotes
      @accepted_quotes = current_company.accepted_quotes
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
    Quote.create(quote_params)
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
end
