# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Inserting default roles
roles = {
    Admin: 'Grants access to all website functionality and management tools.',
    Administrator: 'Grants access to all website functionality and management tools.',

    WebinarsManager: 'Grants access to webinars management tools including "edit", "upload" and "delete" rights.',
    WebinarsViewPublic: 'View access to all public webinars. Default for guest users.',
    WebinarsViewProtected: 'View access to all protected webinars. Default for every authenticated user.',
    WebinarsViewPrivate: 'View access to all private webinars.',

    Translator: 'Grants access to globalization management tools.',

    Instructor: 'Supervisor of students. Grants access to all advanced diploma process assignment tools.',
    Student: 'Default user role for each user created by sign-in interface.'
}

roles.each do |role, description|
  SecurityUsersRole.where(role:role,description:description).first_or_create!
end

# Inserting default security users
users = {

   Admin: {

      Information: {
        email: 'tuvarna.system.master@gmail.com',
        password: 'tuvarnasysmaster2013',
        password_confirmation: 'tuvarnasysmaster2013'
      },
      Details: {
        address: 'Not defined',
        city: 'Not defined.',
        country: 'Not defined',
        egn: '0000000000',
        faculty_number: '000000',
        first_name: 'Admin',
        gender: 'male',
        gsm: '0000000000',
        last_name: 'Account',
        skype: 'Not defined.'
      },
      Roles: %w(Administrator)
   },

   Administrator: {

      Information: {
        email: 'tuvarna.system.super.user@gmail.com',
        password: 'tuvarnasyssuperuser2013',
        password_confirmation: 'tuvarnasyssuperuser2013'
      },
      Details: {
        address: 'Not defined',
        city: 'Not defined',
        country: 'Not defined',
        egn: '0000000000',
        faculty_number: '000000',
        first_name: 'Administrator',
        gender: 'male',
        gsm: '0000000000',
        last_name: 'Account',
        skype: 'Not defined'
      },
      Roles: %w(Admin)
   },

   WebinarsManager: {

      Information: {
        email: 'tuvarna.system.webinarsmanager@gmail.com',
        password: 'tuvarnasyswebinarsmanager2013',
        password_confirmation: 'tuvarnasyswebinarsmanager2013'
      },
      Details: {
        address: 'Not defined',
        city: 'Not defined',
        country: 'Not defined',
        egn: '0000000000',
        faculty_number: '000000',
        first_name: 'Webinars',
        gender: 'male',
        gsm: '0000000000',
        last_name: 'Manager',
        skype: 'Not defined'
      },
      Roles: %w(WebinarsManager WebinarsViewPublic WebinarsViewProtected WebinarsViewPrivate)
   },

   Translator: {

      Information: {
        email: 'tuvarna.system.translator@gmail.com',
        password: 'tuvarnasystranslator2013',
        password_confirmation: 'tuvarnasystranslator2013'
      },
      Details: {
        address: 'Not defined',
        city: 'Not defined',
        country: 'Not defined',
        egn: '0000000000',
        faculty_number: '000000',
        first_name: 'Translator',
        gender: 'male',
        gsm: '0000000000',
        last_name: 'Manager',
        skype: 'Not defined'
      },
      Roles: %w(Translator)
   }
}

users.each do |user, data|

  security_user = SecurityUser.new(data[:Information])
  security_user.activation_code = SecureRandom.hex(32)
  security_user.registration_date = DateTime.now
  security_user.last_log_in_date = DateTime.now
  security_user.is_active = 1
  #security_user.language_code = 'EN'

  unless SecurityUser.where(email: security_user.email).exists?

    data[:Roles].each { |role|
      security_user.security_users_manage_securities.build(security_users_role: SecurityUsersRole.find_by_role(role))
    }

    security_user.save!

    security_users_detail = SecurityUsersDetail.new(data[:Details])
    security_users_detail.security_user_id = security_user.id
    security_users_detail.save!

    #SecurityUsersDetail.where(security_user_id:  security_users_detail.security_user_id)
    #                   .first_or_create!(security_users_detail.attributes
    #                   .delete_if { |key, value| value.nil? })

  end


end




