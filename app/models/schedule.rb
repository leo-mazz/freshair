class Schedule < ApplicationRecord

  after_initialize :default_to_non_current

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :end_date, presence: true
  validates_with ScheduleValidator

  has_one :next_schedule, class_name: 'Schedule'
  has_many :assignments, class_name: 'ScheduleAssignment', dependent: :delete_all

  accepts_nested_attributes_for :assignments, :allow_destroy => true

  def past?
    self.end_date < Date.today
  end

  def self.current
    self.find_by_is_current true
  end

  def self.check_current
    current_schedule = Schedule.current
    return if current_schedule.nil?

    if current_schedule.past?
      next_schedule = current_schedule.next_schedule
      unless next_schedule.nil? or next_schedule.past?
        next_schedule.set_current
      else
        current_schedule.set_non_current
      end
    end
  end

  def set_non_current
    self.is_current = false
    self.save
  end

  def set_current
    if self.past?
      self.errors.add(:is_current, "You can't set as current a schedule that ends in the past!")
      return
    end

    previous_current = Schedule.current
    unless previous_current.nil?
      previous_current.set_non_current
    end

    self.is_current = true
    self.save
  end

  def assignments_on(day)
    # day is an integer 1-7
    self.assignments.where(day_of_week: day)
  end

  # Assumption 1: the schedule won't change between the start_time and end_time
  # The following function will reject (show, start_time, end_time) triplets
  # where the start time and end time are in different schedules because of how
  # schedules are modelled
  def show_valid_for_time?(show, start_time, end_time)

    # Select schedule assignments on same week day corresponding to start time for show
    assignments = self.assignments_on(Time.at(start_time).to_date.cwday)

    # Select schedule assignments with start time of show equal to start time of assignments
    assignments = assignments.select do
      |a| a.start_time.strftime( "%H%M%S%N" ) == Time.at(start_time).to_time.strftime( "%H%M%S%N" )
    end

    # Select end_times such that they don't come before the show's end time
    valid_times = assignments.map(&:endtime).map(&:to_i).select { |time| time >=  end_time}

    valid_times.empty?
  end

  def ends_after_time?(time)
    self.end_date > Time.at(time).to_date
  end

  def self.for_time(time)
    schedule = Schedule.current

    if schedule.nil?
      return nil
    end

    until schedule.ends_after_time?(time) || schedule.successor.nil?
      schedule = schedule.successor
    end

    if schedule.valid_for_time(time)
      return schedule
    else
      return nil
    end

  end


  private

    def default_to_non_current
      self.is_current = false if self.is_current.nil?
    end

end
