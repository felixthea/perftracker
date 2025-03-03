class AddTimezoneSetToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :timezone_set, :boolean
  end
end
