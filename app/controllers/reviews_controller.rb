class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
    render 'index.html.erb'
  end

  def new
    @companies = current_customer.contracts.map{|contract| contract.quote.company}.uniq
    @review = Review.new
    render 'new.html.erb'
  end

  def create
    Review.create(review_params)
    redirect_to "/customers/#{current_customer.id}"
  end

  private

  def review_params
    params.permit(
      :company_id,
      :stars,
      :body
    ).merge(customer_id: current_customer.id)
  end
end
