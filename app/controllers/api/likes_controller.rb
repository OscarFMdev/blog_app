class Api::LikesController < ApplicationController
  before_action :set_like, only: [:show, :update, :destroy]

  # GET api/users/:user_id/posts/:post_id/likes
  def index
    @likes = Like.where(post_id: post.id)
    render json: @likes
  end

  # GET api/users/:user_id/likes/:id
  def show
    render json: @like
  end

  # POST api/users/:user_id/posts/:post_id/likes
  def create
    @like = Like.new(like_params)

    if @like.save
      render json: @like, status: :created, location: @like
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT api/users/:user_id/likes/:id
  def update
    if @like.update(like_params)
      render json: @like
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # DELETE api/users/:user_id/likes/:id
  def destroy
    @like.destroy
  end

  private
    # Callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def like_params
      params.require(:like).permit(:post_id, :user_id)
    end

    def user
      @user = User.find(params[:user_id])
    end

    def post
      @post = Post.find(params[:post_id])
    end
end
