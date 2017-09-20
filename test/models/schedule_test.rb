require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase

  # test_self.current
  test 'Schedule.current returns nil if it needs to' do
    create(:schedule)
    assert_nil Schedule.current
  end


  test 'Schedule.current returns right schedule' do
    schedule = create(:current_schedule)
    assert_equal schedule, Schedule.current
  end



  # test_self.next
  test "Schedule.next returns nil if no schedule is next" do
    current_schedule = create(:current_schedule)
    assert_equal Schedule.current, current_schedule

    assert_equal Schedule.all.count, 1

    assert_nil Schedule.next
  end


  test "Schedule.next returns right next schedule" do
    create(:current_schedule)

    create(:schedule,
      name: 'Future schedule',
      start_date: 1000.days.from_now.to_date,
      end_date: 1002.days.from_now.to_date
    )

    right_schedule = create(:schedule,
      name: 'Less future schedule',
      start_date: 100.days.from_now.to_date,
      end_date: 102.days.from_now.to_date
    )

    assert_equal Schedule.next, right_schedule
  end



  # test_show_valid_for_time?
  test 'show_valid_for_time? returns false if show is not in schedule' do
    schedule = create(:schedule)
    show = create(:show)
    show1 = create(:show, title: 'Bangers and Mash', description: 'Fun show')
    assignment = create(:schedule_assignment, show:show1, schedule:schedule)

    time = assignment.start_time.to_i

    assert_not schedule.show_valid_for_time?(show, time)
  end


  test 'show_valid_for_time? returns false if show is not on the right day' do
    schedule = create(:schedule)
    show = create(:show)
    assignment = create(:schedule_assignment, show:show, schedule:schedule)

    day = assignment.day_of_week
    start_time = assignment.start_time

    start_time_day = start_time.to_date.cwday
    days_delta = day - start_time_day
    seconds_in_day = 60*60*24
    seconds_wrong_delta = seconds_in_day * (days_delta + 1)

    proper_start_time = start_time + seconds_wrong_delta

    assert_not schedule.show_valid_for_time?(show, proper_start_time)
  end


  test 'show_valid_for_time? returns false if show starts before right time' do
    schedule = create(:schedule)
    show = create(:show)
    assignment = create(:schedule_assignment, show:show, schedule:schedule)

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
    schedule = create(:schedule)
    show = create(:show)
    assignment = create(:schedule_assignment, show:show, schedule:schedule)

    day = assignment.day_of_week
    start_time = assignment.start_time

    start_time_day = start_time.to_date.cwday
    days_delta = day - start_time_day
    seconds_in_day = 60*60*24
    seconds_delta = seconds_in_day * days_delta

    proper_start_time = start_time + seconds_delta + 1

    assert_not schedule.show_valid_for_time?(show, proper_start_time)
  end


  test 'show_valid_for_time? returns false if show does not end in time' do
    schedule = create(:schedule)
    show = create(:show)
    assignment = create(:schedule_assignment, show:show, schedule:schedule)

    day = assignment.day_of_week
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
    schedule = create(:schedule)
    show = create(:show)
    assignment = create(:schedule_assignment, show:show, schedule:schedule)

    day = assignment.day_of_week
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
    schedule = create(:schedule)
    show = create(:show)
    assignment = create(:schedule_assignment, show:show, schedule:schedule)

    day = assignment.day_of_week
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



  # test_Schedule_for_time
  test 'Schedule.for_time returns nil when no schedule fits' do
    schedule = create(:current_schedule)
    assert_nil Schedule.for_time(10000.years.from_now.to_time)
  end


  test 'Schedule.for_time returns right schedule' do
    schedule1 = create(:current_schedule)
    schedule2 = create(
      :schedule,
      name: 'Schedule 2',
      start_date: schedule1.end_date+1,
      end_date: schedule1.end_date+2
    )
    schedule3 = create(
      :schedule,
      name: 'Schedule 3',
      start_date: schedule2.end_date+1,
      end_date: schedule2.end_date+2
    )

    time = (schedule2.start_date).to_time
    assert_equal Schedule.for_time(time), schedule2
  end



  # test_clash_with?
  test 'clash_with? returns false if two schedules do not clash' do
    schedule1 = build(:schedule, start_date: Date.today, end_date: Date.tomorrow)
    schedule2 = build(:schedule,
      name: 'Schedule 2',
      start_date: 100.years.from_now.to_date,
      end_date: 101.years.from_now.to_date
    )

    assert_not schedule1.clash_with?(schedule2)
  end


  test 'clash_with? returns true if one schedule is contained by other' do
    schedule1 = build(:schedule, start_date: Date.yesterday, end_date: Date.tomorrow)
    schedule2 = build(:schedule,
      name: 'Schedule 2',
      start_date: Date.today,
      end_date: Date.today
    )

    assert schedule1.clash_with?(schedule2)
  end


  test 'clash_with? returns true if schedule dates are identical' do
    schedule1 = build(:schedule, start_date: Date.yesterday, end_date: Date.tomorrow)
    schedule2 = build(:schedule,
      name: 'Schedule 2',
      start_date: Date.yesterday,
      end_date: Date.tomorrow
    )

    assert schedule1.clash_with?(schedule2)
  end


  test 'clash_with? returns true if one schedule begins during other' do
    schedule1 = build(:schedule, start_date: Date.yesterday, end_date: Date.tomorrow)
    schedule2 = build(:schedule,
      name: 'Schedule 2',
      start_date: Date.yesterday,
      end_date: Date.tomorrow+1
    )

    assert schedule1.clash_with?(schedule2)
  end


  test 'clash_with? returns true if one schedule ends while other is on' do
    schedule1 = build(:schedule, start_date: Date.yesterday, end_date: Date.tomorrow)
    schedule2 = build(:schedule,
      name: 'Schedule 2',
      start_date: Date.tomorrow,
      end_date: Date.tomorrow+1
    )

    assert schedule1.clash_with?(schedule2)
  end


  # test_compatible_with_times?
  test "Schedule.compatible_with_times? returns false with uncompatible times" do
    schedule = create(:current_schedule)

    start_time = "6:00".to_time
    end_time = "7:00".to_time
    day_of_week = DateTime.now.cwday

    assignment = create(:schedule_assignment,
      schedule: schedule,
      start_time: start_time,
      end_time: end_time,
      day_of_week: day_of_week,
    )

    assert_not schedule.compatible_with_times?(start_time, end_time)
  end

  test "Schedule.compatible_with_times? returns true with compatible times" do
    schedule = create(:current_schedule)

    datetime = '2000-01-01 10:00:00'.to_datetime
    start_time = datetime
    end_time = datetime + 1.hour
    day_of_week = datetime.cwday

    assignment = create(:schedule_assignment,
      schedule: schedule,
      start_time: start_time.to_time,
      end_time: end_time.to_time,
      day_of_week: day_of_week
    )

    assert schedule.compatible_with_times?(start_time + 2.hour, end_time + 3.hours)
  end

end
