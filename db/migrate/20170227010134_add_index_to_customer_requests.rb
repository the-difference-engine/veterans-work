class AddIndexToCustomerRequests < ActiveRecord::Migration[5.0]
  def change
    add_index :customer_requests, :expires_date
  end
end
