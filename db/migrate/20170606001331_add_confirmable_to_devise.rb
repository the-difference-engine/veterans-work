class AddConfirmableToDevise < ActiveRecord::Migration[5.0]
  # Note: You can't use change, as User.update_all will fail in the down migration
  def up
    add_column :companies, :confirmation_token, :string
    add_column :companies, :confirmed_at, :datetime
    add_column :companies, :confirmation_sent_at, :datetime
    # add_column :companies, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :companies, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # companies as confirmed, do the following
    execute("UPDATE companies SET confirmed_at = NOW()")
    # All existing user accounts should be able to log in after this.
    # Remind: Rails using SQLite as default. And SQLite has no such function :NOW.
    # Use :date('now') instead of :NOW when using SQLite.
    # => execute("UPDATE companies SET confirmed_at = date('now')")
    # Or => User.all.update_all confirmed_at: Time.now
  end

  def down
    remove_columns :companies, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :companies, :unconfirmed_email # Only if using reconfirmable
  end
end
