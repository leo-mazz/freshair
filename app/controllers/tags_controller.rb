class TagsController < ApplicationController

  def show
    @tag = Tag.friendly.find(params[:id])
    @title = @tag.name
    @tag_posts = @tag.posts.order(created_at: :desc)
  end

end
