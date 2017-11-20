class AddViewDate < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :view_date, :date
  end
end
