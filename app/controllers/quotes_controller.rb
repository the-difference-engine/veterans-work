class QuotesController < ApplicationController

  def new
    render 'new.html.erb'
  end

  def create
    redirect_to '/customer_requests'
  end

end
