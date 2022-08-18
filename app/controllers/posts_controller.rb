class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments, :likes)
  end

  def show
    @post = Post.find(params[:user_id])
    @user = @post.author
    @comments = @post.comments
  end
end
