class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :company_id
      t.integer :quantity

      t.timestamps
    end
  end
end
