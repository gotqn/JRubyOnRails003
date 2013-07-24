class SecurityUsersAssignment < ActiveRecord::Base

  ROLE_TYPE = %w[ student instructor ]

  # Accessible columns
  attr_accessible :role,
                  :is_disabled

  # Relationships
  belongs_to :security_user
  belongs_to :assignment

  # Validations
  validates :role, presence: true, inclusion: ROLE_TYPE

end
