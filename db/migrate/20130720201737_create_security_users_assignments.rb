class CreateSecurityUsersAssignments < ActiveRecord::Migration
  def change
    create_table :security_users_assignments, id:false do |t|
      t.string :role
      t.references :security_user
      t.references :assignment
    end
    add_index :security_users_assignments, :security_user_id
    add_index :security_users_assignments, :assignment_id
  end
end
