class AddLatitudeAndLongitudeToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :latitude, :float
    add_column :companies, :longitude, :float
  end
end
