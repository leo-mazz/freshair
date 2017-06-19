class TagsController < ApplicationController

  def show
    @tag = Tag.friendly.find(params[:id])
    @tag_posts = @tag.posts.order(created_at: :desc)
  end

end
