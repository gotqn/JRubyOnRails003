class AddSecurityUserIdToSecurityUsersDetails < ActiveRecord::Migration
  def change
    add_column :security_users_details, :security_user_id, :integer
  end
end
