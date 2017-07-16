class HomeController < ApplicationController

  def index
    @latest_posts = Post.order(created_at: :desc).limit(6)
    @highlights = HighlightsService.get_highlights
    @post_types = Tag.post_types
  end

end
