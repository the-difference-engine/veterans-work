class ReviewsController < ApplicationController
#test
  def index
    @reviews = Review.all
    render 'index.html.erb'
  end

  def new
    if params[:company]
      @company = Company.where(id: params[:company])
    else
      @companies = current_customer.contracts.includes(:company).map(&:company).uniq
    end
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
