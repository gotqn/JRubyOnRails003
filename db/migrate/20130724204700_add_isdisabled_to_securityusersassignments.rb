class AddIsdisabledToSecurityusersassignments < ActiveRecord::Migration
  def change
    add_column :security_users_assignments, :is_disabled, :boolean
  end
end
