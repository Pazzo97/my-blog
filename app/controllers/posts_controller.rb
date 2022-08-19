class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc).includes(:comments, :likes)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = current_user.posts.new(post_params)
    @post.likes_count = 0
    @post.comments_count = 0
    @post.update_post_counter

    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = 'Post saved successfully'
          redirect_to new_user_post_path(current_user)
        else
          flash.now[:error] = 'Error: Post could not be saved. Please try again.'
          render :new
        end
      end
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
