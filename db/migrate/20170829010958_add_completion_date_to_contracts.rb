class AddCompletionDateToContracts < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :completion_date, :date
  end
end
