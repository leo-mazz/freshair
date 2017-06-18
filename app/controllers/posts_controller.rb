class PostsController < ApplicationController

  def show
    @post = Post.friendly.find(params[:id])
    @title = @post.title
  end

end
