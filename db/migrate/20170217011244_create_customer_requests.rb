class CreateCustomerRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_requests do |t|

      t.timestamps
    end
  end
end
