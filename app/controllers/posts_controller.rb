class PostsController < ApplicationController
  load_and_authorize_resource
  
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

  def destroy
    @post = Post.find(params[:id])
    @user = @post.author_id
    respond_to do |format|
      format.html do
        if @post.destroy
          @post.author.decrement!(:posts_count)
          flash[:success] = 'Post deleted successfully'
          redirect_to user_posts_path(current_user)
        else
          flash.now[:error] = 'Error: Post could not be deleted. Please try again.'
          redirect_to :back
        end
      end
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
