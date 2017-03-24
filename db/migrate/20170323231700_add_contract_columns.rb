class AddContractColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :quote_id, :string
    add_column :contracts, :customer_request_id, :string
  end
end
