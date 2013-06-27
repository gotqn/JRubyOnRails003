class SecurityUsersManageSecurity < ActiveRecord::Base

  # Relationships
  belongs_to :security_user
  belongs_to :security_users_role

  # Accessible columns
  attr_accessible :security_users_role

end
