class CreateReviewModel < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :customer_id
      t.integer :company_id
      t.integer :stars
      t.text :body

      t.timestamps
    end
  end
end
