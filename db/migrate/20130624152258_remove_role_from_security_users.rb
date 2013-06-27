class RemoveRoleFromSecurityUsers < ActiveRecord::Migration
  def up
    remove_column :security_users, :role
  end

  def down
    add_column :security_users, :role, :string
  end
end
