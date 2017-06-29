class PostsController < ApplicationController

  def show
    @post = Post.friendly.find(params[:id])
    @title = @post.title
  end

  def index
    @title = 'Latest posts'
    @posts = Post.order(created_at: :desc).page(params[:page])
    @post_types = Tag.post_types
  end

end
