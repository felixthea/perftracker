class RenameTypeColumnInReviews < ActiveRecord::Migration[7.2]
  def change
    rename_column :reviews, :type, :review_type
  end
end
