class PagesController < ApplicationController

  def index
    @full_width_page = true
    if current_company
      redirect_to "/customer_requests"
    elsif  current_customer
      redirect_to "/customers/#{current_customer.id}"
    elsif current_admin
      redirect_to "/admins"
    else
      render "index.html.erb"
    end
  end

  def about
    @full_width_page = true
    render "about.html"
  end

  def how
    @full_width_page = true
  end

end
