class AssignmentComment < ActiveRecord::Base

  # Accessible columns
  attr_accessible :comment,
                  :security_user_id,
                  :created_at

  # Relationships
  belongs_to :assignment
  belongs_to :security_user

end
