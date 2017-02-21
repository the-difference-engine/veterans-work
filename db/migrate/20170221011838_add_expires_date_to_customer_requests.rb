class AddExpiresDateToCustomerRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :customer_requests, :expires_date, :date
  end
end
