class AddAcceptedBoolean < ActiveRecord::Migration[5.0]
  def change
    add_column :quotes, :accepted, :boolean
  end
end
