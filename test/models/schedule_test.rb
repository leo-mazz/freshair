require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase

  # test_Schedule.current
  test 'Schedule.current leaves it current if it is ok' do
    schedule = Schedule.create(name: 'Current', end_date: Date.tomorrow)
    schedule.set_current

    assert_equal schedule, Schedule.current
  end

  test 'Schedule.current sets as non current if it is not ok' do
    schedule = Schedule.create(name: 'Past', end_date: Date.yesterday)
    Schedule.current.update(is_current: false)
    schedule.update(is_current: true)

    assert_nil Schedule.current
  end

  test 'Schedule.current sets as current a successor if it can' do
    schedule3 = Schedule.create(end_date: Date.today, name: 'Three')
    schedule2 = Schedule.create(end_date: Date.today - 1, name: 'Two', next_schedule: schedule3)
    schedule1 = Schedule.create(end_date: Date.today - 2, name: 'One', next_schedule: schedule2)
    Schedule.current.update(is_current:false)
    schedule1.update(is_current:true)

    assert_equal Schedule.current, schedule3
  end

  test 'Schedule.current sets as non current all successors if has to' do
    schedule3 = Schedule.create(end_date: Date.today - 2, name: 'Three')
    schedule2 = Schedule.create(end_date: Date.today - 3, name: 'Two', next_schedule: schedule3)
    schedule1 = Schedule.create(end_date: Date.today - 4, name: 'One', next_schedule: schedule2)
    Schedule.current.update(is_current:false)
    schedule1.update(is_current:true)

    assert_nil Schedule.current
  end



  # test_set_current
  test 'set_current works' do
    schedule = schedules(:one)
    assert schedule.is_current

    schedule2 = Schedule.create(name: 'New current', end_date: Date.tomorrow)
    assert_not schedule2.is_current
    schedule2.set_current

    assert_equal Schedule.current, schedule2
  end



  # test_set_non_current
  test 'set_non_current works' do
    schedule = schedules(:one)
    assert schedule.is_current

    schedule.set_non_current
    assert_not schedule.is_current
  end



  # test_show_valid_for_time?
  test 'show_valid_for_time? returns false if show is not in schedule' do
    schedule = schedules(:two)
    show = shows(:two)

    time = schedule.assignments.first.start_time.to_i

    assert_not schedule.show_valid_for_time?(show, time)
  end

  test 'show_valid_for_time? returns false if show is not on the right day' do
    schedule = schedules(:one)
    assignment = schedule.assignments.first

    day = assignment.day_of_week
    show = assignment.show
    start_time = assignment.start_time

    start_time_day = start_time.to_date.cwday
    days_delta = day - start_time_day
    seconds_in_day = 60*60*24
    seconds_wrong_delta = seconds_in_day * (days_delta + 1)

    proper_start_time = start_time + seconds_wrong_delta

    assert_not schedule.show_valid_for_time?(show, proper_start_time)
  end

  test 'show_valid_for_time? returns false if show starts before right time' do
    schedule = schedules(:one)
    assignment = schedule.assignments.first

    day = assignment.day_of_week
    show = assignment.show
    start_time = assignment.start_time

    start_time_day = start_time.to_date.cwday
    days_delta = day - start_time_day
    seconds_in_day = 60*60*24
    seconds_delta = seconds_in_day * days_delta

    proper_start_time = start_time + seconds_delta - 1

    assert_not schedule.show_valid_for_time?(show, proper_start_time)
  end

  test 'show_valid_for_time? returns false if show starts after right time' do
    schedule = schedules(:one)
    assignment = schedule.assignments.first

    day = assignment.day_of_week
    show = assignment.show
    start_time = assignment.start_time

    start_time_day = start_time.to_date.cwday
    days_delta = day - start_time_day
    seconds_in_day = 60*60*24
    seconds_delta = seconds_in_day * days_delta

    proper_start_time = start_time + seconds_delta + 1

    assert_not schedule.show_valid_for_time?(show, proper_start_time)
  end

  test 'show_valid_for_time? returns false if show does not end in time' do
    schedule = schedules(:one)
    assignment = schedule.assignments.first

    day = assignment.day_of_week
    show = assignment.show
    start_time = assignment.start_time
    end_time = assignment.end_time

    start_time_day = start_time.to_date.cwday
    days_delta = day - start_time_day
    seconds_in_day = 60*60*24
    seconds_delta = seconds_in_day * days_delta

    proper_start_time = start_time + seconds_delta
    proper_end_time = end_time + seconds_delta + 1

    assert_not schedule.show_valid_for_time?(show, proper_start_time, proper_end_time)
  end

  test 'show_valid_for_time? returns true if all is right' do
    schedule = schedules(:one)
    assignment = schedule.assignments.first

    day = assignment.day_of_week
    show = assignment.show
    start_time = assignment.start_time
    end_time = assignment.end_time

    start_time_day = start_time.to_date.cwday
    days_delta = day - start_time_day
    seconds_in_day = 60*60*24
    seconds_delta = seconds_in_day * days_delta

    proper_start_time = start_time + seconds_delta
    proper_end_time = end_time + seconds_delta

    assert schedule.show_valid_for_time?(show, proper_start_time, proper_end_time)
  end

  test 'show_valid_for_time? returns true if all is right but end time is early' do
    schedule = schedules(:one)
    assignment = schedule.assignments.first

    day = assignment.day_of_week
    show = assignment.show
    start_time = assignment.start_time
    end_time = assignment.end_time

    start_time_day = start_time.to_date.cwday
    days_delta = day - start_time_day
    seconds_in_day = 60*60*24
    seconds_delta = seconds_in_day * days_delta

    proper_start_time = start_time + seconds_delta
    proper_end_time = end_time + seconds_delta - 1

    assert schedule.show_valid_for_time?(show, proper_start_time, proper_end_time)
  end



  # test_ends_after_time?
  test 'ends_after_time? returns true' do
    schedule = schedules(:one)
    seconds_in_year = 60*60*24*365
    long_time = (seconds_in_year * 1000)
    past_time = Time.now.to_i - long_time
    assert schedule.ends_after_time?(past_time)
  end

  test 'ends_after_time? returns false' do
    schedule = schedules(:one)
    seconds_in_year = 60*60*24*365
    long_time = (seconds_in_year * 1000)
    future_time = Time.now.to_i + long_time
    assert_not schedule.ends_after_time?(future_time)
  end

  test 'ends_after_time? handles corner-case' do
    schedule = schedules(:one)
    time = schedule.end_date.to_time.to_i
    assert_not schedule.ends_after_time?(time)
  end



  # test_Schedule_for_time
  test 'Schedule.for_time returns nil when given a time that is not future' do
    schedules(:one).set_current
    assert_nil Schedule.for_time(Time.now)
  end

  test 'Schedule.for_time returns nil when no schedule is current' do
    schedules(:one).set_non_current
    assert_nil Schedule.for_time(Time.now)
  end

  test 'Schedule.for_time returns something when current schedule works' do
    tomorrow = Date.today + 1
    schedule = Schedule.create(end_date: tomorrow, name: 'Ethernal schedule')
    schedule.set_current

    assert_not_nil Schedule.for_time(Time.now + 1)
  end

  test 'Schedule.for_time returns nil when current schedule does not work and has no successor' do
    tomorrow = Date.today + 1
    schedule = Schedule.create(end_date: Date.today, name: 'Ethernal schedule')
    schedule.set_current

    assert_nil Schedule.for_time(tomorrow.to_time)
  end

  test 'Schedule.for_time returns something when a successor schedule works' do
    schedule3 = Schedule.create(end_date: Date.today + 2, name: 'Three')
    schedule2 = Schedule.create(end_date: Date.today + 1, name: 'Two', next_schedule: schedule3)
    schedule1 = Schedule.create(end_date: Date.today, name: 'One', next_schedule: schedule2)
    schedule1.set_current

    tomorrow = Date.today + 1
    assert_not_nil Schedule.for_time((Date.today + 2).to_time - 1)
  end

  test 'Schedule.for_time returns nil when no successor schedule works' do
    schedule3 = Schedule.create(end_date: Date.today + 2, name: 'Three')
    schedule2 = Schedule.create(end_date: Date.today + 1, name: 'Two', next_schedule: schedule3)
    schedule1 = Schedule.create(end_date: Date.today, name: 'One', next_schedule: schedule2)
    schedule1.set_current

    tomorrow = Date.today + 1
    assert_nil Schedule.for_time((Date.today + 2).to_time + 1)
  end

end
