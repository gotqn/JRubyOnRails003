class Issue < ActiveRecord::Base

  # Accessible columns
  attr_accessible :contacts,
                  :description,
                  :instantiated_by,
                  :is_proceed,
                  :title,
                  :created_at

  # Loading custom validators
  require 'lib/email_format_validator'

  # Validations
  validates :contacts, presence: true, email_format: true
  validates :description, presence: true, length: { in: 16..256 }
  validates :instantiated_by, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: 'Only letters allowed' },length: { in: 2..32}
  validates :title, presence: true, length: { in: 2..32}

  # Methods

  def send_issue_notification
    SecurityUserMailer.issue_notification(self).deliver
  end

end
