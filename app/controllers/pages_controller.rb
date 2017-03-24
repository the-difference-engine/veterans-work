class PagesController < ApplicationController

  def index
    @homepage = true
    if current_company
      redirect_to "/customer_requests"
    elsif  current_customer
      redirect_to "/customers/#{current_customer.id}"
    else
      render "index.html.erb"
    end
  end

  def about
    render "about.html"
  end

end
