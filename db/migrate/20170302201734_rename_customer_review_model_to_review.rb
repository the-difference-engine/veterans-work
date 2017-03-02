class RenameCustomerReviewModelToReview < ActiveRecord::Migration[5.0]
  def change
    rename_table :customer_reviews, :reviews
  end
end
