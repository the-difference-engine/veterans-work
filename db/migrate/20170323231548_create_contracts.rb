class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|

      t.timestamps
    end
  end
end
