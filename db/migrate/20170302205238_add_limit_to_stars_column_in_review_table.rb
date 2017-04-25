class AddLimitToStarsColumnInReviewTable < ActiveRecord::Migration[5.0]
  def change
    change_column :reviews, :stars, :integer, :in => 1..5
  end
end
