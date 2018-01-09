class CreateCredits < ActiveRecord::Migration[5.1]
  def change
    create_table :credits do |t|

      t.timestamps
    end
  end
end
