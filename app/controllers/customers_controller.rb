class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = Customer.find(params[:id])
    if current_customer.id == @customer.id
      render "show.html.erb"
    else
      redirect_to '/'
    end
  end
end
