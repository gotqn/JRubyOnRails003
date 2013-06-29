class SecurityUsersRole < ActiveRecord::Base

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

end
