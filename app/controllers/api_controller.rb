class ApiController < ActionController::Base

  def shows
    @shows = User.find_by_email(params[:email]).shows

    render json: @shows, only: [:slug, :title, :tag_line, :description]
  end

  def current_schedule
    @current = Schedule.current

    if @current.nil?

      render json: 'null'
    else
      @response = {}
      WeekService.days_dic.each do |day, integer|
        @response[day.downcase.to_sym] = @current.assignments.where(day_of_week: integer).to_json(only: [:start_time, :end_time], methods: [:show_slug])
      end
      # TODO: still doesn't work for free schedules
      render json: @response
    end
  end

end
