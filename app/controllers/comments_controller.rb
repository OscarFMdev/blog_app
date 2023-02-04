class CommentsController < ApplicationController
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comments_params)
    @current_user = current_user
    @comment.author = @current_user

    if @comment.save
      redirect_to user_post_path(id: params.require(:post_id), author_id: params.require(:user_id))
    else
      render 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back_or_to user_posts_path(current_user), notice: 'Deleted!' }
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:text, :author_id, :post_id)
  end
end