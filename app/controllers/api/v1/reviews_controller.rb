class Api::V1::ReviewsController < ApplicationController
  def create
    review = Review.new(
      body: params[:body],
      company_id: params[:company_id],
      customer_id: params[:customer_id],
      stars: params[:stars]
    )
    if review.save
      render json: { }, status: 200
    else
      render json: { status: 404 }.merge(
        errors: review.errors.full_messages
      ), status: 404
    end
  end
end
