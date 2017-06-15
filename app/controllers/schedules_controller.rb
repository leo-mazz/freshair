class SchedulesController < ApplicationController

  def current
    @title = 'Schedule'
    @schedule = Schedule.current
    @days_of_week = WeekService.days_dic
  end

end
