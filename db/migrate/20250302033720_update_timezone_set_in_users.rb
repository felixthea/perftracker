class UpdateTimezoneSetInUsers < ActiveRecord::Migration[7.2]
  def up
    # Step 1: Set NULL values to false before enforcing NOT NULL constraint
    User.where(timezone_set: nil).update_all(timezone_set: false)

    # Step 2: Add NOT NULL constraint
    change_column_default :users, :timezone_set, false
    change_column_null :users, :timezone_set, false
  end

  def down
    # Rollback changes if needed
    change_column_null :users, :timezone_set, true
    change_column_default :users, :timezone_set, nil
  end
end
