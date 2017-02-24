class CreateCompanyServices < ActiveRecord::Migration[5.0]
  def change
    create_table :company_services do |t|
      t.integer :company_id
      t.integer :service_category_id

      t.timestamps
    end
  end
end
