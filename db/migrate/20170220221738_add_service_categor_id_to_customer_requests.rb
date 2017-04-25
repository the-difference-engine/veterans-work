class AddServiceCategorIdToCustomerRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :customer_requests, :service_category_id, :integer
  end
end
