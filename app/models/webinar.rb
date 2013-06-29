class Webinar < ActiveRecord::Base

  # Hardcoded variables
  ACCESS_TYPES = %w[Public Protected Private]
  ACCESS_TYPES_MESSAGES = [ ['Public', 'visible for guests, average and system users' ],
                            ['Protected', 'visible for average and system users'],
                            ['Private', 'visible for system users'],
                            ['skip', 'all']]

  # Accessible columns
  attr_accessible :is_active, :name, :access_type, :summary, :video, :created_at, :id, :short_summary

  has_attached_file :video, styles: {medium: { geometry: '640x480', format: 'flv', :streaming => true },
                                     thumb: { geometry: '200x125#', format: 'jpg', time:10 } },
                    processors: [:ffmpeg],
                    url: '/webinars/:id/:style/:basename.:extension',
                    path: ":rails_root/public/webinars/:id/:style/:basename.:extension"

  # Relationships
  # has_one :secutity_users

  # Validations
  validates :name, presence: true, length: { in: 4..128 }, uniqueness: true
  validates :access_type, presence: true, inclusion: ACCESS_TYPES
  validates :summary, presence: true,length: { in: 32..512 }
  validates :video, presence: true
  validate :is_video_file_uploaded

  # Methods

  def is_video_file_uploaded
    if self.video?
      unless self.video.content_type.match(/video/)
        errors.add(:video?, 'Video file must be uploaded')
      end
    end
  end

  def get_video_duration
    movie = FFMPEG::Movie.new(video.path(:original))
    movie.duration
  end

  def short_summary (max_length)
    shorter_summary = summary
    if shorter_summary.length > max_length
      shorter_summary = shorter_summary.split(' ').each_with_object('') {
        |x,ob| break ob unless (ob.length + ' '.length + x.length <= max_length)
        ob << (' ' + x)
      } .strip + ' ...'
    end
    shorter_summary
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def self.advanced_search(search_name,search_access_type,search_is_active)

    @parameters_coding = ''
    @parameters_coding += !search_name.nil? ? '1' : '0'
    @parameters_coding += !search_access_type.nil? ? '1' : '0'
    @parameters_coding += !search_is_active.nil? ? '1' : '0'

    case @parameters_coding
      when '000'
        find(:all)
      when '001'
        where('is_active = ?', search_is_active)
      when '010'
        where('access_type = ?', search_access_type)
      when '011'
        where('access_type = ? AND is_active = ?', search_access_type, search_is_active)
      when '100'
        where('name LIKE ?', "%#{search_name}%")
      when '101'
        where('name LIKE ? AND is_active = ?', "%#{search_name}%", search_is_active)
      when '110'
        where('name LIKE ? AND access_type = ?', "%#{search_name}%", search_access_type)
      when '111'
        where('name LIKE ? AND access_type = ? AND is_active = ?', "%#{search_name}%", search_access_type, search_is_active)
      else
        find(:all)
    end
  end

end

