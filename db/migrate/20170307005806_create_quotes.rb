class CreateQuotes < ActiveRecord::Migration[5.0]
  def change
    create_table :quotes do |t|
      t.integer :customer_request_id
      t.integer :company_id
      t.decimal :materials_cost_estimate
      t.decimal :labor_cost_estimate
      t.date :start_date
      t.date :completion_date_estimate
      t.text :notes

      t.timestamps
    end
  end
end
