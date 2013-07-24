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

end
