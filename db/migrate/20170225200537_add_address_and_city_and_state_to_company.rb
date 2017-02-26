class AddAddressAndCityAndStateToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :address, :string
    add_column :companies, :city, :string
    add_column :companies, :state, :string
  end
end
