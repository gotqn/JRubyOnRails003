class CreateSecurityUsers < ActiveRecord::Migration
  def change
    create_table :security_users do |t|
      t.string :email
      t.string :password_digest
      t.datetime :registration_date
      t.datetime :last_log_in_date
      t.boolean :is_active
      t.string :activation_code
      t.string :role
      t.string :language_code

      t.timestamps
end
end
end
