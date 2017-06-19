class HomeController < ApplicationController

  def index
    @latest_posts = Post.order(created_at: :desc)
    @post_types = Tag.post_types
  end

end
