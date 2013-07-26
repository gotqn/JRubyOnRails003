class Assignment < ActiveRecord::Base

  STATUSES = %w[ opened ongoing closed ]
  TYPES = %w[ public private ]

  # Accessible columns
  attr_accessible :description,
                  :is_disabled,
                  :status,
                  :subject,
                  :technologies,
                  :type

  # Relationships
  has_many :security_users_assignments
  has_many :security_users, through: :security_users_assignments

  # Access to other relationships models' fields
  accepts_nested_attributes_for :security_users
  accepts_nested_attributes_for :security_users_assignments

  # Validations
  validates :status, presence: true, inclusion: STATUSES
  validates :type, presence: true, inclusion: TYPES
  validates :subject, presence: true,
            format: { with: /\A[a-zA-Z\s]+\z/, message: 'Only letters and blank spaces allowed' },
            length: { in: 8..32}
  validates :technologies, presence: true, length: { in: 32..128}
  validates :description, presence: true, length: { in: 32..512}

  # Methods
  def instantiate_private(student_id, student_view, instructor_id, instructor_view)
    status = {}
    if SecurityUser.exists?(student_id) and SecurityUser.exists?(instructor_id)
      self.security_users_assignments.build(security_user:SecurityUser.find_by_id(student_id),
                                            role:'student',
                                            is_disabled:student_view)
      self.security_users_assignments.build(security_user:SecurityUser.find_by_id(instructor_id),
                                            role:'instructor',
                                            is_disabled:instructor_view)
    else
    #self.security_users_manage_securities.build(security_users_role: SecurityUsersRole.find_by_id(role[1]))
    end
  end

  def instantiate_public(student_id, student_view, instructor_id, instructor_view)

  end

end
