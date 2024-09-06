class CreateExpectations < ActiveRecord::Migration[7.2]
  def change
    create_table :expectations do |t|
      t.string :text

      t.timestamps
    end
  end
end
