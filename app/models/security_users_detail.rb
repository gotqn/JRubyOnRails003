class SecurityUsersDetail < ActiveRecord::Base

  # Model Variables
  GENDER_TYPES = [ 'male', 'female' ]

  # Accessible columns
  attr_accessible :address,
                  :city,
                  :country,
                  :egn,
                  :faculty_number,
                  :first_name,
                  :gender,
                  :gsm,
                  :last_name,
                  :skype,
                  :security_user_id

  # Relationships
  belongs_to :security_user

  # Validations
  validates :egn, length: { is: 10 } , presence: true
  validates :faculty_number, length: { is: 6 }, presence: true
  validates :first_name, length: { in: 2..128}, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: 'Only letters allowed' }
  validates :last_name, length: { in: 2..128}, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: 'Only letters allowed' }
  validates :gender, presence:true, inclusion: GENDER_TYPES
  validates :gsm, length: { in: 2..16}, format: { with: /\A[0-9]+\z/, message: 'Only numbers allowed' }
  validates :skype, length: { in: 2..128}

  # Methods
  def is_profile_mine (security_user_id, text_on_true, text_on_false)
    # Placeholders {first_name}, {last_name}
    (self.security_user_id == security_user_id) ? result_text = text_on_true : result_text = text_on_false

    if result_text.include? '{first_name}' or result_text.include? '{last_name}'
      result_text.sub! '{first_name}', self.first_name
      result_text.sub! '{last_name}', self.last_name
    end

    result_text
  end

end
