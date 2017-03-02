class CustomerReviewsController < ApplicationController

    def new
    render 'new.html.erb'
  end

  def create
    CustomerReview.create(
      customer_id: current_customer.id,
      company_id: params[:company_id],
      body: params[:body],
      stars: params[:stars]
      )
    redirect_to "/customers/#{current_customer.id}"
  end
end
