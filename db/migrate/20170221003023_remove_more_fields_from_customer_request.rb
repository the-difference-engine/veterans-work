class RemoveMoreFieldsFromCustomerRequest < ActiveRecord::Migration[5.0]
  def change
    remove_column :customer_requests, :project_type, :string
    remove_column :customer_requests, :location, :string
    remove_column :customer_requests, :customer_availability, :string
  end
end
