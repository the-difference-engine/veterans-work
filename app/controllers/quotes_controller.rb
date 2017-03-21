class QuotesController < ApplicationController

  def index
    if current_customer
      @customer_requests = current_customer.customer_requests
    elsif current_company
    else 
      redirect_to "/"
    end
  end

  def new
    @customer_request_id = params[:customer_request_id]
    @quote = Quote.new
    render 'new.html.erb'
  end

  def create
    Quote.create(quote_params)
    redirect_to '/customer_requests'
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
    ).merge(company_id: current_company.id)
  end
end
# maybe this is how you do it see when the person gets to the new quote form, the quote instance is populated with it. There's a bunch of ways to do this. You could store the id in the session and retrieve it as well.