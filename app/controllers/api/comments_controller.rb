class Api::CommentsController < ApplicationController
  # GET api/users/:user_id/:post_id/comments
  def index
    @comments = Comment.where(post_id: post.id)
    render json: @comments
  end

  # GET api/users/:user_id/comments/:id
  def show
    render json: @comment
  end

  # comment api/users/:user_id/comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT api/users/:user_id/comments/:id
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE api/users/:user_id/comments/:id
  def destroy
    @comment.destroy
  end

  private

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:title, :text)
  end

  def user
    @user = User.find(params[:user_id])
  end

  def post
    @post = Post.find(params[:post_id])
  end
end
