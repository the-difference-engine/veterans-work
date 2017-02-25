class AddServiceRadiusToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :service_radius, :float
  end
end
