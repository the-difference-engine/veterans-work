class AddConfirmableToCustomers < ActiveRecord::Migration[5.0]
  def up
    add_column :customers, :confirmation_token, :string
    add_column :customers, :confirmed_at, :datetime
    add_column :customers, :confirmation_sent_at, :datetime
    # add_column :customers, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :customers, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # customers as confirmed, do the following
    execute("UPDATE customers SET confirmed_at = NOW()")
    # All existing user accounts should be able to log in after this.
    # Remind: Rails using SQLite as default. And SQLite has no such function :NOW.
    # Use :date('now') instead of :NOW when using SQLite.
    # => execute("UPDATE customers SET confirmed_at = date('now')")
    # Or => User.all.update_all confirmed_at: Time.now
  end

  def down
    remove_columns :customers, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :customers, :unconfirmed_email # Only if using reconfirmable
  end
end
