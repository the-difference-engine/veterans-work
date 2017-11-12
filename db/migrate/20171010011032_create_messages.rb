class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :conversation_id
      t.integer :company_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
