class CreateSecurityUsersManageSecurities < ActiveRecord::Migration
  def change
    create_table :security_users_manage_securities do |t|
      t.belongs_to :security_user
      t.belongs_to :security_users_role

      t.timestamps
    end
    add_index :security_users_manage_securities, :security_user_id
    add_index :security_users_manage_securities, :security_users_role_id
  end
end
