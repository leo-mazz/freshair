class PodcastsController < ApplicationController
  def show
    @podcast = Podcast.find(params[:id])
    @title = @podcast.show.title + ' > ' + @podcast.broadcast_date.to_s
  end
end
