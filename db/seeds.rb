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

    Teacher: 'Supervisor of students. Grants access to all advanced diploma process assignment tools.',
    Student: 'Default user role for each user created by sign-in interface.'
}

roles.each do |role, description|
  SecurityUsersRole.where(role:role,description:description).first_or_create!
end

# Inserting default security users





