class CreateSecurityUsersDetails < ActiveRecord::Migration
  def change
    create_table :security_users_details do |t|
      t.string :faculty_number
      t.string :egn
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :address
      t.string :city
      t.string :country
      t.string :gsm
      t.string :skype

      t.timestamps
    end
  end
end
