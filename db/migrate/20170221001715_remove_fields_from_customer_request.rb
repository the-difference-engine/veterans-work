class RemoveFieldsFromCustomerRequest < ActiveRecord::Migration[5.0]
  def change
    rename_column :customer_requests, :name, :address
    rename_column :customer_requests, :phone, :city
    rename_column :customer_requests, :email, :state
    rename_column :customer_requests, :industry, :zipcode
    remove_column :customer_requests, :job_type
    remove_column :customer_requests, :explanation

    add_column :customer_requests, :description, :text

  end
end
