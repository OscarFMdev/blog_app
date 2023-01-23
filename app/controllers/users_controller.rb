class UsersController < ApplicationController
  def index
    users
    posts
    comments
  end

  def show
    user
    posts
  end

  private

  def user
    @user = User.find(params[:id])
  end

  def users
    @users = User.all
  end

  def posts
    @posts = Post.where(author_id: params[:id])
  end

  def comments
    @comments = Comment.where(post_id: params[:id])
  end
end
