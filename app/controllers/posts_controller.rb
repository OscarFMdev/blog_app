class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    user
    @current_user = current_user
  end

  def show
    @current_user = current_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    @post.save
    redirect_to user_posts_path(current_user)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(current_user), notice: 'Your product has been successfully deleted'
  end


  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def post
    @post = Post.includes(:comments, :likes).find(params[:id])
  end

  def posts
    @posts = Post.where(author_id: user.id)
  end

  def user
    @user = User.find(params[:user_id])
  end
end