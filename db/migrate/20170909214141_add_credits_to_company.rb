class AddCreditsToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :credits, :integer, default: 0
  end
end
