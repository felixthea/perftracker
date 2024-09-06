class CreateAccomplishments < ActiveRecord::Migration[7.2]
  def change
    create_table :accomplishments do |t|
      t.string :text

      t.timestamps
    end
  end
end
