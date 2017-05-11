class ReviewsController < ApplicationController

  def index
    reviews = Review.all
    render component: 'ReviewList', props: { reviews: reviews }, tag: 'span', class: 'review'
  end

  def new
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
