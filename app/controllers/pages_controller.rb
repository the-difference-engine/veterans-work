class PagesController < ApplicationController

  def index
    @page_class = "infopage  home-image"

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
    @page_class = "infopage  about-image"
    render "about.html"
  end
end
