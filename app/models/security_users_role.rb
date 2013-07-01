class SecurityUsersRole < ActiveRecord::Base

  # callbacks
  before_destroy :check_for_users_in_this_role

  # Accessible columns
  attr_accessible :description,
                  :role

  # Relationships
  has_many :security_users_manage_securities
  has_many :security_users, through: :security_users_manage_securities


  # Validations
  validates :role, presence: true, length: { in: 4..32 }, uniqueness: true,
            format:{ with: /^[a-zA-Z]*$/, message: 'Only letters allowed.' }
  validates :description, length: {  in: 12..256 }, presence: true

  # Methods
  def get_security_users_by_role

      SecurityUser.joins(:security_users_roles)
                  .where(security_users_roles:{role:self.role})
                  .includes(:security_users_detail)
  end

  def check_for_users_in_this_role
    status = true
    if self.security_users.count > 0
      self.errors[:deletion_status] = 'Cannot delete security role with active users in it.'
      status = false
    else
      self.errors[:deletion_status] = 'OK.'
    end
    status
  end

end

