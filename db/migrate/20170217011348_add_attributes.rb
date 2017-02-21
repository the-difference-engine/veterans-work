class AddAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :customer_requests, :name, :string
    add_column :customer_requests, :phone, :string
    add_column :customer_requests, :email, :string
  end
end
