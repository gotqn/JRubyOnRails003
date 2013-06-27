class AddAuthTokenToSecurityUsers < ActiveRecord::Migration
  def change
    add_column :security_users, :auth_token, :string
  end
end
