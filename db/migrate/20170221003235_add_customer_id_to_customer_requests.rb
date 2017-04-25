class AddCustomerIdToCustomerRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :customer_requests, :customer_id, :integer
  end
end
