class Api::V1::ReviewsController < ApplicationController
  def create
    review = Review.new(
      body: params[:body],
      company_id: params[:company_id],
      customer_id: params[:customer_id],
    )
    if review.save
      render json: { status: 200 }.merge(errors: review.errors.full_messages)
    else
      render json: { status: 404 }.merge(errors: review.errors.full_messages)
    end
  end
end
