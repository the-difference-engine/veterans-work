class AddCompanyIdToContractsTable < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :company_id, :integer
  end
end
