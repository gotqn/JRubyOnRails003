class AddCaptchaToSecurityUsers < ActiveRecord::Migration
  def change
    add_column :security_users, :captcha, :string
  end
end
