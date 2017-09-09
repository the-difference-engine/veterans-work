class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :company_id
      t.decimal :amount

      t.timestamps
    end
  end
end
