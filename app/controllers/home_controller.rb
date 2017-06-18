class HomeController < ApplicationController

  def index
    @latest_posts = Post.order(created_at: :desc)
  end

end
