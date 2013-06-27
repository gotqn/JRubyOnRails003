class CreateSecurityUsersRoles < ActiveRecord::Migration
  def change
    create_table :security_users_roles do |t|
      t.string :role
      t.string :description

      t.timestamps
    end
  end
end
