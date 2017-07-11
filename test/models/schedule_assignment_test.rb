require 'test_helper'

class ScheduleAssignmentTest < ActiveSupport::TestCase

  # test_clash_with?
  test 'clash_with? returns false if two assignments on different days' do
    show = create(:show)
    schedule = create(:schedule)
    assignment1 = ScheduleAssignment.create(
      day_of_week:1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 10:00:00'.to_time,
      end_time: '2000-01-01 11:00:00'.to_time
    )

    assignment2 = ScheduleAssignment.create(
      day_of_week: 2,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 10:00:00'.to_time,
      end_time: '2000-01-01 11:00:00'.to_time
    )

    assert_not assignment1.clash_with?(assignment2)
  end

  test 'clash_with? returns false if two assignments clearly do not clash' do
    show = create(:show)
    schedule = create(:schedule)
    assignment1 = ScheduleAssignment.create(
      day_of_week:1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 10:00:00'.to_time,
      end_time: '2000-01-01 11:00:00'.to_time
    )

    assignment2 = ScheduleAssignment.create(
      day_of_week: 1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 20:00:00'.to_time,
      end_time: '2000-01-01 21:00:00'.to_time
    )

    assert_not assignment1.clash_with?(assignment2)
  end

  test 'clash_with? returns false if assignment ends when other starts' do
    show = create(:show)
    schedule = create(:schedule)
    assignment1 = ScheduleAssignment.create(
      day_of_week:1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 10:00:00'.to_time,
      end_time: '2000-01-01 11:00:00'.to_time
    )

    assignment2 = ScheduleAssignment.create(
      day_of_week: 1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 11:00:00'.to_time,
      end_time: '2000-01-01 12:00:00'.to_time
    )

    assert_not assignment1.clash_with?(assignment2)
  end

  test 'clash_with? returns false if assignment starts when other ends' do
    show = create(:show)
    schedule = create(:schedule)
    assignment1 = ScheduleAssignment.create(
      day_of_week:1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 10:00:00'.to_time,
      end_time: '2000-01-01 11:00:00'.to_time
    )

    assignment2 = ScheduleAssignment.create(
      day_of_week: 1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 09:00:00'.to_time,
      end_time: '2000-01-01 10:00:00'.to_time
    )

    assert_not assignment1.clash_with?(assignment2)
  end

  test 'clash_with? returns true if one assignment is contained by other' do
    show = create(:show)
    schedule = create(:schedule)
    assignment1 = ScheduleAssignment.create(
      day_of_week:1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 11:00:00'.to_time,
      end_time: '2000-01-01 12:00:00'.to_time
    )

    assignment2 = ScheduleAssignment.create(
      day_of_week: 1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 10:00:00'.to_time,
      end_time: '2000-01-01 13:00:00'.to_time
    )

    assert assignment1.clash_with?(assignment2)
  end

  test 'clash_with? returns true if assignments are identical' do
    show = create(:show)
    schedule = create(:schedule)
    assignment1 = ScheduleAssignment.create(
      day_of_week:1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 11:00:00'.to_time,
      end_time: '2000-01-01 12:00:00'.to_time
    )

    assignment2 = ScheduleAssignment.create(
      day_of_week: 1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 11:00:00'.to_time,
      end_time: '2000-01-01 12:00:00'.to_time
    )

    assert assignment1.clash_with?(assignment2)
  end

  test 'clash_with? returns true if one assignment begins during other' do
    show = create(:show)
    schedule = create(:schedule)
    assignment1 = ScheduleAssignment.create(
      day_of_week: 1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 10:00:00'.to_time,
      end_time: '2000-01-01 13:00:00'.to_time
    )

    assignment2 = ScheduleAssignment.create(
      day_of_week: 1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 09:00:00'.to_time,
      end_time: '2000-01-01 11:00:00'.to_time
    )

    assert assignment1.clash_with?(assignment2)
  end

  test 'clash_with? returns true if one assignment ends while other is on' do
    show = create(:show)
    schedule = create(:schedule)
    assignment1 = ScheduleAssignment.create(
      day_of_week:1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 08:00:00'.to_time,
      end_time: '2000-01-01 10:00:00'.to_time
    )

    assignment2 = ScheduleAssignment.create(
      day_of_week: 1,
      show: show,
      schedule: schedule,
      start_time: '2000-01-01 09:00:00'.to_time,
      end_time: '2000-01-01 11:00:00'.to_time
    )

    assert assignment1.clash_with?(assignment2)
  end

end
