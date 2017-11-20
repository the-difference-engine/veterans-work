class ChangeViewDate < ActiveRecord::Migration[5.1]
  def change
    change_column :quotes, :view_date, :datetime
  end
end
