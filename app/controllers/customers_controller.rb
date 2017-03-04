class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = Customer.find(params[:id])
    render "show.html.erb"
  end

end
