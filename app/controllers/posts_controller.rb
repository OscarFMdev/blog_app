class PostsController < ApplicationController
  def index
    posts
    user
  end

  def show
    post
    comments
  end

  private
  def post
    @post = Post.find(params[:user_id])
  end
  def posts
    @posts = Post.where(:author_id => user.id)
  end
  def user
    @user = User.find(params[:user_id])
  end
  def comments
    @comments = Comment.where( :post_id => post.id )
  end
end