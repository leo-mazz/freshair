class FeedController < ApplicationController

  def general
    @all_posts = Post.order(created_at: :desc).last(20)
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

end
