class QuotesController < ApplicationController
  def index
    if current_customer
      @open_quotes = current_customer.open_quotes
      @accepted_quotes = current_customer.accepted_quotes
    elsif current_company
      @open_quotes = current_company.open_quotes.order('start_date')
      @accepted_quotes = current_company.accepted_quotes
    else
      redirect_to '/'
    end
  end

  def new
    @quote = Quote.new
    @quote.customer_request_id = params[:customer_request_id]
    render 'new.html.erb'
  end

  def create
    if current_company.has_credit?
      @quote = Quote.new(quote_params)
      sanitize_blank_costs(@quote)
      if has_fewer_than_3_siblings?(@quote)
        if @quote.save
          current_company.decrement!(:credits, 1)
          flash[:notice] = 'New Quote created successfully!'
          redirect_to '/customer_requests'
        else
          flash[:notice] = "Sorry, the quote did not save. Please try again. #{@quote.errors.full_messages.join(', ')}."
          render 'new.html.erb'
        end
      else
        flash[:notice] = 'Sorry, this Customer Request has already recieved its max number of quotes.'
        render 'new.html.erb'
      end
    else
      flash[:notice] = 'Sorry, you don\'t have an available credit with which to bid on this customer request.'
      redirect_to '/orders/new'
    end
  end

  def show
    @quote = Quote.find(params[:id])
    @customer_request = @quote.customer_request
    @company = @quote.company
    if current_customer
      @quote.update(customer_viewed: true)
    end
  end

  def update
    @quote = Quote.find(params[:id])
    if current_customer
      @quote.update(accepted: false)
      CompanyMailer.decline_email(@quote).deliver_now
      redirect_to '/quotes'
    else
      redirect_to "/quotes/#{@quote.id}"
    end
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

  def has_fewer_than_3_siblings?(quote)
    quote.customer_request.quotes.count < 3
  end
end
