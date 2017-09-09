class CreateCredits < ActiveRecord::Migration[5.1]
  def change
    create_table :credits do |t|
      t.decimal :cost
      t.integer :order_id
      t.integer :quote_id

      t.timestamps
    end
  end
end
