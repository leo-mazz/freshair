class SchedulesController < ApplicationController

  def current
    @title = 'Schedule'
    @schedule = Schedule.current
    @days_of_week = WeekService.days_dic
  end

  def next
    @title = 'Next schedule'
    @current_schedule = Schedule.current

    if @current_schedule.nil?
      # If there's no current schedule, go to current schedule page anyway
      redirect_to current_schedule_path
    end

    @schedule = @current_schedule.next_schedule

    if @schedule.nil?
      # If there's no next schedule, go to current schedule page
      redirect_to current_schedule_path
    end

    @days_of_week = WeekService.days_dic
  end

end
