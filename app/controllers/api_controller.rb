class ApiController < ActionController::Base

  def shows_for_user
    @user = User.find_by_email(params[:email])
    if @user.nil?
      render json: nil
    else
      @shows = @user.shows
      @shows = @shows.map do |s|
        {slug: s.slug, title: s.title, tag_line: s.tag_line, description: s.description, link: s.link, pic: s.pic_uri}
      end

      render json: @shows
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
      render json: {title: @show.title, tag_line: @show.tag_line, description: @show.description, link: @show.link, pic: @show.pic_uri}
    end
  end

  def check_broadcast_time
    @show = Show.find_by_slug(params[:slug])
    start_time = params[:start].to_i

    if @show.nil?
      response =  'No show matching slug'
    elsif params[:end].nil?
      response = @show.check_broadcast_time(start_time)
    else
      end_time = params[:end].to_i
      response = @show.check_broadcast_time(start_time, end_time)
    end

    render plain: response
  end

end
