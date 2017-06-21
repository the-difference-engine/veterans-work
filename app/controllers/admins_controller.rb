class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if current_admin
      @recent_customers = Customer.last(10) || []
      @recent_companies = Company.last(10) || []
      @recent_customer_requests = CustomerRequest.last(10) || []
      @recent_quotes = Quote.last(10) || []
    end
  end
end
