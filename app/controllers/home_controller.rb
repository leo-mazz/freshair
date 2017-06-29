class HomeController < ApplicationController

  def index
    @latest_posts = Post.order(created_at: :desc).limit(6)
    @post_types = Tag.post_types
  end

end
