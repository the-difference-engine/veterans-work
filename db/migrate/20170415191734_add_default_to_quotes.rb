class AddDefaultToQuotes < ActiveRecord::Migration[5.0]
  def change
    change_column_default :quotes, :materials_cost_estimate, 0
    change_column_default :quotes, :labor_cost_estimate, 0
  end
end
