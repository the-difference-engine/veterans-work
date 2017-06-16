class AddArchiveBooleanToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :archive, :boolean, default: false
  end
end
