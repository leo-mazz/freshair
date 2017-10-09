class PodcastsController < ApplicationController

  def show
    @podcast = Podcast.find(params[:id])
    @title = @podcast.show.title + ' > ' + @podcast.date.to_s
  end

end
