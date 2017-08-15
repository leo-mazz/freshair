class Schedule < ApplicationRecord

  after_initialize :set_defaults

  validates :name, presence: true
  validates :name, uniqueness: true
  validates_with ScheduleValidator

  # https://stackoverflow.com/questions/16782990/rails-how-to-populate-parent-object-id-using-nested-attributes-for-child-obje
  has_many :assignments, class_name: 'ScheduleAssignment', dependent: :delete_all, :inverse_of => :schedule

  accepts_nested_attributes_for :assignments, :allow_destroy => true

  def past?
    self.end_date < Date.today
  end

  def future?
    self.start_date > Date.today
  end

  def current?
    !self.future? && !self.past?
  end

  def expiring?
    (self.end_date - Date.today).to_i <= 10
  end

  def self.current
    Schedule.where('start_date <= ? AND end_date >= ?', Date.today, Date.today).take
  end

  def self.next
    Schedule.where('start_date >= ? ', Date.tomorrow).order(start_date: :asc).first
  end

  def assignments_on(day)
    # day is an integer 1-7
    self.assignments.where(day_of_week: day)
  end

  # Assumption: the schedule won't change between the start_time and end_time
  # This can't happen because of how schedules are modelled: they are assumed
  # to start at midnight of a day and assignments cannot end after 23.59
  def show_valid_for_time?(show, start_time, end_time=nil)
    # Select schedule assignments on same week day corresponding to start time for show
    assignments = self.assignments_on(Time.at(start_time).to_date.cwday)

    # Select assignments involving passed show
    assignments = assignments.where(show: show)

    # Select schedule assignments with start time of show equal to start time of assignments
    assignments = assignments.select do
      |a| a.start_time.utc.strftime( "%H:%M:%S" ) == Time.at(start_time).utc.strftime( "%H:%M:%S" )
    end


    return (not assignments.empty?) if end_time == nil

    # Select end_times such that they don't come before the show's end time
    valid_times = assignments.map(&:end_time).select { |time| time.utc.strftime( "%H:%M:%S" ) >=  Time.at(end_time).utc.strftime( "%H:%M:%S" )}

    not valid_times.empty?
  end


  def self.for_time(time)
    date = Time.at(time).to_date
    Schedule.where('start_date <= ? AND end_date >= ?', date, date).take
  end

  def clash_with?(schedule)
    # Two schedules clash if, either the first contains the second,
      (((self.start_date <= schedule.start_date) && (self.end_date >= schedule.end_date)) ||
        # or the first starts while the second is on,
        ((self.start_date >= schedule.start_date) && (self.start_date <= schedule.end_date)) ||
        # or if the first ends while the second is on
        ((self.end_date >= schedule.start_date) && (self.end_date <= schedule.end_date)))
  end

  def compatible_with_times?(start_time, end_time)
    # Note: this method should be used to check whether datetimes clash with some
    # assignments and won't check whether datetimes are in the schedule's frame
    # of validity
    # Assumption: bookings' start and end times are on the same day
    day_of_week = start_time.wday

    booking = ScheduleAssignment.new(
      start_time: start_time.to_time,
      end_time: end_time.to_time,
      day_of_week: start_time.wday
    )

    assignments = self.assignments_on(day_of_week)

    return booking.compatible_with?(assignments)
  end

  private

    def set_defaults
      self.is_free_schedule = false if self.is_free_schedule.nil?
    end

end
