class Show < ApplicationRecord
  include Rails.application.routes.url_helpers

  mount_uploader :pic, ShowPicUploader

  # has_and_belongs_to_many :users, join_table: :hosts_shows
  has_many :podcasts, dependent: :delete_all
  has_many :show_memberships, dependent: :delete_all
  has_many :users, through: :show_memberships
  has_many :show_scopes, dependent: :delete_all
  has_many :posts

  accepts_nested_attributes_for :show_memberships, :allow_destroy => true

  validates_presence_of :title, :description
  validates :title, uniqueness: true
  validates :slug, uniqueness: true

  # For friendlier URLs, use the title of the show instead of its id
  extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  scope :by_title, -> { order(:title) }

  def broadcast_times
    day_times = []
    current_schedule = Schedule.current

    return if current_schedule.nil?

    current_schedule.assignments.each do |assignment|
      if assignment.show.id == self.id
        day_time = {}
        day_time[:day] = assignment.day_name
        day_time[:start] = assignment.start_time.strftime('%H:%M')
        day_time[:end] = assignment.end_time.strftime('%H:%M')

        day_times << day_time
      end
    end

    # TODO: change this to allow multiple broadcast times to be returned. But
    # careful, will break a few things (expecting a single result to be returned)
    # like broadcast time labels. Sort them out first
    day_times.first

  end


  def self.active
    all = Show.all
    active = []

    all.each do |show|
      active << show if not show.broadcast_times.nil?
    end

    active
  end

# TODO: I don't expect following two methods to work in production
  def link
    Rails.root.join(shows_path(self)).to_s
  end

  def pic_uri
    unless self.pic.url.nil?
      Rails.root.join(self.pic.resized.url).to_s
    end
  end

  def check_broadcast_time(start_time, end_time=nil)

    if (not end_time.nil?) and (end_time <= start_time)
      return 'The end time should come after the start time'
    end

    if Time.now.to_i >= start_time
      return 'The past is past. Please enquiry about the future'
    end

    schedule = Schedule.for_time(start_time)
    if schedule.nil?
      return 'No schedule information for this date'
    end

    unless schedule.show_valid_for_time?(self, start_time, end_time)
      'The show has not been allocated this time'
    else
      'ok'
    end

  end

end
