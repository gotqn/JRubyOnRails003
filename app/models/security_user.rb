# encoding: UTF-8

class SecurityUser < ActiveRecord::Base

  before_create { generate_token(:auth_token) }

  # Model Variables
  LANGUAGE_CODES = %w[ BG EN RU ]

  LANGUAGE_DETAILS =  {
                       BG: {
                              Name: 'Български',
                              Flag: ''
                           },
                       EN: {
                              Name: 'English',
                              Flag: ''
                           },
                       RU: {
                              Name: 'Руский',
                              Flag: ''
                           }
                    }

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
                  :language_code,
                  :captcha,
                  :security_users_detail

  # Relationships
  has_one :security_users_detail, dependent: :destroy
  has_many :security_users_manage_securities
  has_many :security_users_roles, through: :security_users_manage_securities

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
  validates :language_code, presence: true, inclusion: LANGUAGE_CODES

  has_secure_password

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

end
