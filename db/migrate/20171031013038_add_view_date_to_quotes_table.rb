class AddViewDateToQuotesTable < ActiveRecord::Migration[5.1]
  def change
    add_column :quotes, :view_date, :date
  end
end
