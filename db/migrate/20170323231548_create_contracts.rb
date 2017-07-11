class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|
      t.integer :quote_id
      t.integer :customer_request_id

      t.timestamps
    end
  end
end
