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

    # The following method checks if a certain security user is a specific role
    def is_user_in_role (security_user_id, role)
      SecurityUser.joins(:security_users_roles)
                  .where(security_users_roles:{role:role})
                  .exists?(["security_users.id=#{security_user_id.to_s}"])
    end

    #
    def get_security_users_by_role
      SecurityUser.joins(:security_users_roles)
                  .where(security_users_roles:{role:self.role})
                  .includes(:security_users_detail)
    end

    #
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

    # Get security users ids and names hashes, filtered by security user role(s).
    def self.get_users_names_by_roles (roles)
      params = {}
      roles.each { |role|
        params[role] = {}
        self.find_by_role(role).get_security_users_by_role.each do |security_user|
          security_users_details = security_user.get_security_user_details
          unless security_users_details.nil? or security_users_details.first_name.nil? or security_users_details.last_name.nil?
            params[role][security_user.id] = security_users_details.first_name + ' ' + security_users_details.last_name
          end
        end
      }
      params
    end

end

