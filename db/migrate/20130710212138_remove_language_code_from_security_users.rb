class RemoveLanguageCodeFromSecurityUsers < ActiveRecord::Migration
  def up
    remove_column :security_users, :language_code
  end

  def down
    add_column :security_users, :language_code, :string
  end
end
