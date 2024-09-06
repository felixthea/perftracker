class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.string :result
      t.datetime :start
      t.datetime :end
      t.string :type

      t.timestamps
    end
  end
end
