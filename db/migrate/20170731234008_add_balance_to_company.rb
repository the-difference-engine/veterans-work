class AddBalanceToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :balance, :integer
  end
end
