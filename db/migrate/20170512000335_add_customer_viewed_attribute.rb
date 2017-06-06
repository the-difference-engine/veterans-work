class AddCustomerViewedAttribute < ActiveRecord::Migration[5.0]
  def change
    add_column :quotes, :customer_viewed, :boolean, default: false
  end
end
