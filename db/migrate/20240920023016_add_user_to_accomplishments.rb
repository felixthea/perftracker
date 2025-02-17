class AddUserToAccomplishments < ActiveRecord::Migration[7.2]
  def change
    add_reference :accomplishments, :user, null: false, foreign_key: true
  end
end
