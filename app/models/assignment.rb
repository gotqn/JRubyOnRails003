class Assignment < ActiveRecord::Base

  STATUSES = %w[ opened closed ] #ongoing removed ongoing
  TYPES = %w[ public private ]

  # Accessible columns
  attr_accessible :description,
                  :is_disabled,
                  :status,
                  :subject,
                  :technologies,
                  :assignment_type,
                  :created_at

  # Relationships
  has_many :security_users_assignments
  has_many :security_users, through: :security_users_assignments
  has_many :assignment_comments

  # Access to other relationships models' fields
  accepts_nested_attributes_for :security_users_assignments
  accepts_nested_attributes_for :assignment_comments

  # Validations
  validates :status, presence: true, inclusion: STATUSES
  validates :assignment_type, presence: true, inclusion: TYPES
  validates :subject, presence: true,
            format: { with: /\A[a-zA-Z\s]+\z/, message: 'Only letters and blank spaces allowed' },
            length: { in: 8..32 }
  validates :technologies, presence: true, length: { in: 32..256 }
  validates :description, presence: true, length: { in: 32..512 }

  # Scopes

    # The scope below returns all "public" assignments
    scope :get_public, -> { where(assignment_type: 'public') }

    # The scope below returns all "private" assignments for particular user
    scope :get_private, ->(security_user_id,role){
                            joins(:security_users_assignments)
                            .where(security_users_assignments: { security_user_id:security_user_id, role:role })
                            }
    #
    scope :get_details, -> { joins(:security_users)
                             .joins('INNER JOIN security_users_details ON security_users_details.security_user_id = security_users.id')
                             .select('assignments.*,
                                      security_users_assignments.role as sua_role,
                                      security_users_assignments.is_disabled as sua_is_disabled,
                                      security_users_details.first_name as sud_first_name,
                                      security_users_details.last_name as sud_last_name') }



  # Methods

    # The following method instantiate a "private" assignment. This type of assignment is
    # visible only by its "instructor" and "student" owners
    def instantiate_private (student_id, student_view, instructor_id, instructor_view, assignment_details, is_user_instructor)

      self.subject = assignment_details[:subject]
      self.technologies = assignment_details[:technologies]
      self.description = assignment_details[:description]
      self.assignment_type = 'private'
      self.status = 'opened'
      self.is_disabled = 0

      if SecurityUser.exists?(student_id) and SecurityUser.exists?(instructor_id)
        self.security_users_assignments.build(security_user:SecurityUser.find_by_id(student_id),
                                              role:'student',
                                              is_disabled:student_view)
        self.security_users_assignments.build(security_user:SecurityUser.find_by_id(instructor_id),
                                              role:'instructor',
                                              is_disabled:instructor_view)
        result = { status: 'ok', message: 'Instantiation completed.'}
      else
        if is_user_instructor
          render_params = { mode: 'instructor', params: SecurityUsersRole.get_users_names_by_role('Student')}
        else
          render_params = { mode: 'student', params: SecurityUsersRole.get_users_names_by_role('Instructor')}
        end
        result = { status: 'error', message: 'No such student or instructor accounts.', render_params:render_params }
      end
      result
    end

    # The following method instantiate a "public" assignment. This type of assignment is
    # visible by all "instructor" and "student"
    def instantiate_public (instructor_id, assignment_details)

      self.subject = assignment_details[:subject]
      self.technologies = assignment_details[:technologies]
      self.description = assignment_details[:description]
      self.assignment_type = 'public'
      self.status = 'opened'
      self.is_disabled = 0

      if SecurityUser.exists?(instructor_id)
        self.security_users_assignments.build(security_user:SecurityUser.find_by_id(instructor_id),
                                              role:'instructor',
                                              is_disabled:0)
        result = { status: 'ok', message: 'Instantiation completed.' }
      else
        render_params = { mode: 'student', params: SecurityUsersRole.get_users_names_by_role('Instructor')}
        result = { status: 'error', message: 'No such instructor account.', render_params:render_params }
      end
      result
    end

    # The following method returns assignments depending on passed render mode and user id.
    # The render modes are 'public', 'private' and 'default'(used for users in 'AssignmentManager' only).
    def get_assignments_by_render_mode (render_mode, security_user_id, search_params)

      search_options = Assignment.search(search_params)
      security_users_role = SecurityUsersRole.new
      #assignments = search_options.result

      case render_mode
        when 'public'
          assignments = Assignment.get_public.get_details.search(search_params).result
        when 'private'
          if security_users_role.is_user_in_role(security_user_id,'Instructor')
            assignments = Assignment.get_private(security_user_id,'instructor').get_details.search(search_params).result
          else
            assignments = Assignment.get_private(security_user_id,'student').get_details.search(search_params).result
          end
          #assignments.get_private(security_user_id).get_details
        else
          if security_users_role.is_user_in_role(security_user_id,'AssignmentManager')
            assignments = Assignment.all.get_details.search(search_params).result
            #assignments.get_details
          else
            #assignments.get_private(security_user_id).get_details
            if security_users_role.is_user_in_role(security_user_id,'Instructor')
              assignments = Assignment.get_private(security_user_id,'instructor').get_details.search(search_params).result
            else
              assignments = Assignment.get_private(security_user_id,'student').get_details.search(search_params).result
            end
            #assignments = Assignment.get_private(security_user_id).get_details.search(search_params).result
          end
      end

      { assignments: assignments, search_options: search_options }
    end

end
