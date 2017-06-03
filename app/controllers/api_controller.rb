class ApiController < ActionController::Base

  def shows_for_user
    @user = User.find_by_email(params[:email])
    if @user.nil?
      render json: nil
    else
      @shows = @user.shows
      render json: @shows, only: [:slug, :title, :tag_line, :description, :pic], methods: [:link]
    end
  end

  def current_schedule
    @current = Schedule.current

    if @current.nil?

      render json: nil
    else
      @response = {}
      WeekService.days_dic.each do |day, integer|
        @response[day.downcase.to_sym] = @current.assignments.where(day_of_week: integer).to_json(only: [:start_time, :end_time], methods: [:show_slug])
      end
      # TODO: still doesn't work for free schedules
      render json: @response
    end
  end

  def show_by_slug
    @show = Show.find_by_slug(params[:slug])
    if @show.nil?
      render json: nil
    else
      render json: @show, only: [:title, :tag_line, :description, :pic], methods: [:link]
    end
  end

end
