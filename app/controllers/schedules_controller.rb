class SchedulesController < ApplicationController

  def current
    @title = 'Schedule'
    @schedule = Schedule.current
    @next_schedule = Schedule.next
    @days_of_week = WeekService.days_dic
  end

  def next
    @title = 'Next schedule'
    @schedule = Schedule.next

    if @schedule.nil?
      # If there's no next schedule, go to current schedule page
      redirect_to current_schedule_path
    end

    @days_of_week = WeekService.days_dic
  end

end
