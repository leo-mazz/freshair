class SchedulesController < ApplicationController

  def current
    @title = 'Schedule'
    # This will check whether current schedule is still valid before showing it
    # TODO: might be worth, even just as an exercise, to get rid of this and
    # make it a daily task (gem 'whenever' might be interesting to look into)
    Schedule.check_current
    @schedule = Schedule.current
    @days_of_week = WeekService.days_dic
  end

end
