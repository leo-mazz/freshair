class ShowsController < ApplicationController
  before_action :set_shows, only: [:index, :all]

  def index
    @title = 'Shows'
    @display_all = false
    if @active_shows.count == 0
      # If there's no active show, display all of the shows
      redirect_to all_shows_path
    else
      @shows = @active_shows
    end
  end

  def all
    @title = 'Shows > All'
    @display_all = true
    @shows = @all_shows
    # We want the same view as for shows index, but with all shows
    render 'index'
  end

  def show
    @show = Show.friendly.find(params[:id])
    @title = 'Shows > ' + @show.title
    @show_posts = @show.posts.order(created_at: :desc)
  end


  private

  def set_shows
    @all_shows = Show.by_title
    @active_shows = Show.active
  end

end
