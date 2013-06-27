class AddPasswordResetToSecurityUsers < ActiveRecord::Migration
  def change
    add_column :security_users, :password_reset_token, :string
    add_column :security_users, :password_reset_sent_at, :datetime
  end
end
