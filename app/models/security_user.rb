# encoding: UTF-8

class SecurityUser < ActiveRecord::Base

  before_create { generate_token(:auth_token) }

  # Model Variables
  #LANGUAGE_CODES = %w[ BG EN RU ]

  #LANGUAGE_DETAILS =  {
  #                     BG: {
  #                            Name: 'Български',
  #                            Flag: ''
  #                         },
  #                     EN: {
  #                            Name: 'English',
  #                           Flag: ''
  #                         },
  #                     RU: {
  #                            Name: 'Руский',
  #                            Flag: ''
  #                         }
  #                  }

  # Loading custom validators
  require 'lib/email_format_validator'
  require 'lib/date_format_validator'

  # Accessible columns
  attr_accessible :activation_code,
                  :email,
                  :is_active,
                  :last_log_in_date,
                  :password,
                  :password_confirmation,
                  :registration_date,
                  #:language_code,
                  :captcha,
                  :security_users_detail

  # Relationships
  has_one :security_users_detail, dependent: :destroy
  has_many :security_users_manage_securities
  has_many :security_users_roles, through: :security_users_manage_securities
  has_many :security_users_assignments
  has_many :assignments, through: :security_users_assignments
  has_many :assignment_comments

  # Access to other relationships models' fields
  accepts_nested_attributes_for :security_users_roles
  #accepts_nested_attributes_for :security_users_detail

  # Validations
  validates :email, presence: true, email_format: true, length: { maximum: 128 } #uniqueness: true
  validates :password, length: { in: 8..32 }, presence: true
  validates :password_confirmation, presence: true
  validates :activation_code, length: { is: 64 }, presence: true
  validates :last_log_in_date, date_format:true, presence: true
  validates :registration_date, date_format:true , presence: true
  #validates :language_code, presence: true, inclusion: LANGUAGE_CODES

  has_secure_password

  # Methods

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while SecurityUser.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    SecurityUserMailer.password_reset(self).deliver
  end

  def send_email_confirmation
    SecurityUserMailer.email_confirmation(self).deliver
  end

  def change_user_status(status)
    self.is_active = status
    save!(validate: false)
  end

  def set_default_relations
    security_users_detail = SecurityUsersDetail.new
    security_users_detail.security_user_id = self.id
    security_users_detail.save!(validate: false)
  end

  def is_profile_completed
    is_completed = true
    if  self.security_users_detail.nil?
      is_completed = false
    else
      self.security_users_detail.attributes.each do |field_name, field_value|
        if field_value.nil? || field_value.blank?
          is_completed = false
          break
        end
      end
    end
    is_completed
  end

  def get_security_user_details
    SecurityUsersDetail.find_by_security_user_id(self.id)
  end

  def advanced_authentication(password)
    status = true
    if self.authenticate(password)
      self.last_log_in_date = DateTime.now
      save!(validate: false)
    else
      status = false
    end
    status
  end

  def is_profile_mine (security_user_id, text_on_true, text_on_false)
    # Placeholders {first_name}, {last_name}
    (self.id == security_user_id) ? result_text = text_on_true : result_text = text_on_false

    if result_text.include? '{first_name}' or result_text.include? '{last_name}'
      security_users_detail = SecurityUsersDetail.find_by_security_user_id(self.id)
      if security_users_detail.nil?
        result_text.sub! '{first_name}', 'Unknown'
        result_text.sub! '{last_name}', 'Unknown'
      else
        result_text.sub! '{first_name}', (security_users_detail.first_name.nil? ? 'Unknown': security_users_detail.first_name)
        result_text.sub! '{last_name}', (security_users_detail.last_name.nil? ? 'Unknown': security_users_detail.last_name)
      end
    end

    result_text
  end

  def get_security_user_roles_by_id (get_ids_only)

    if get_ids_only
      SecurityUsersRole.joins(:security_users)
      .where(security_users:{id:self.id})
      .select('security_users_roles.id')
      .pluck('security_users_roles.id')
    else
      SecurityUsersRole.joins(:security_users)
      .where(security_users:{id:self.id})
    end
  end

  def manage_security_users_roles (roles)
    self.security_users_manage_securities.delete_all
    unless roles.nil?
      roles.each do |role|
        self.security_users_manage_securities.build(security_users_role: SecurityUsersRole.find_by_id(role[1]))
      end
    end
    save!(validate: false)
  end

  def manage_default_settings
    self.send_email_confirmation unless self.is_active == 1
    self.set_default_relations
    #self.security_users_manage_securities = nil
    self.security_users_manage_securities.build(security_users_role: SecurityUsersRole.find_by_role('Student'))
    self.save!(validate: false)
  end

  def is_security_user_instructor
    !self.security_users_roles.find_by_role('Instructor').nil?
  end

  # The following method defines security access to assignment functionality.
  # The highest security access is return.
  def get_assignment_access
    security_users_roles = self.security_users_roles
    case
      when security_users_roles.any?{|h| h[:role] == 'AssignmentManager'}
        access = 'manager'
      when security_users_roles.any?{|h| h[:role] == 'Instructor'}
        access = 'instructor'
      when security_users_roles.any?{|h| h[:role] == 'Student'}
        access = 'student'
      else
        access = 'No access.'
    end
    access
  end


end
