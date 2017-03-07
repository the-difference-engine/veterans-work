class CreateQuotes < ActiveRecord::Migration[5.0]
  def change
    create_table :quotes do |t|
      t.integer :customer_id
      t.integer :company_id
      t.decimal :materials_cost_estimate
      t.decimal :labor_cost_estimate
      t.string :start_date
      t.string :completion_date_estimate
      t.text :materials
      t.text :notes

      t.timestamps
    end
  end
end
