class MoreRequestAttrs < ActiveRecord::Migration[5.0]
  def change
    add_column :customer_requests, :industry, :string
    add_column :customer_requests, :job_type, :string
    add_column :customer_requests, :project_type, :string
    add_column :customer_requests, :explanation, :string
    add_column :customer_requests, :location, :string
    add_column :customer_requests, :customer_availability, :string
  end
end
