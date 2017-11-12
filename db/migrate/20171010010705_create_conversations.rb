class CreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      t.integer :customer_id
      t.integer :company_id
      t.integer :quote_id

      t.timestamps
    end
  end
end
