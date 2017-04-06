class PagesController < ApplicationController

  def index
    @homepage = true
    if current_company
      redirect_to "/customer_requests"
    elsif  current_customer
      redirect_to "/customers/#{current_customer.id}"
    elsif current_admin
      redirect_to "/pages/admin_panel"
    else
      render "index.html.erb"
    end
  end

  def about
    render "about.html"
  end

end
