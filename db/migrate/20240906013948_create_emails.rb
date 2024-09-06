class CreateEmails < ActiveRecord::Migration[7.2]
  def change
    create_table :emails do |t|
      t.string :recipient_email
      t.string :subject
      t.string :body

      t.timestamps
    end
  end
end
