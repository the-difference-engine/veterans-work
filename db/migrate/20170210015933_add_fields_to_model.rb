class AddFieldsToModel < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :name, :string
    add_column :companies, :zip_code, :string
    add_column :companies, :phone, :string
    add_column :companies, :description, :text
    add_column :companies, :url, :string
  end
end
