class ScheduleAssignment < ApplicationRecord

  validates_presence_of :day_of_week, :start_time, :end_time, :show_id, :schedule_id
  # Day of week is an integer. 1 is Monday, 7 is Sunday
  validates_inclusion_of :day_of_week, :in => 1..7
  validates_with ScheduleAssignmentValidator

  belongs_to :schedule
  belongs_to :show

  def day_name
    day = self.day_of_week
    WeekService.days_dic_reverse[day] unless (day < 1) or (day > 7)
  end

  # TODO: test carefully clash_with
  def clash_with?(assignment)
    # Two assignments clash if they're on the same day
    (self.day_of_week == assignment.day_of_week) and
    # and if, either the first contains the second,
      (((self.start_time <= assignment.start_time) and (self.end_time >= assignment.end_time)) or
        # or the first starts while the second is on,
        ((self.start_time >= assignment.start_time) and (self.start_time < assignment.end_time)) or
        # or if the first ends while the second is on
        ((self.end_time > assignment.start_time) and (self.end_time <= assignment.end_time)))
  end

  def compatible_with?(assignments)
    assignments = assignments - [self]

    assignments.each do |a|
      return false if self.clash_with?(a)
    end

    true
  end

end
