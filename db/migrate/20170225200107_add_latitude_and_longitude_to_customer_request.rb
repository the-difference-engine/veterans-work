class AddLatitudeAndLongitudeToCustomerRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :customer_requests, :latitude, :float
    add_column :customer_requests, :longitude, :float
  end
end
