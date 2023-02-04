class Api::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET api/users/:user_id/posts
  def index
    @posts = Post.where(author_id: user.id)
    render json: @posts
  end

  # GET api/users/:user_id/posts/:id
  def show
    render json: @post
  end

  # POST api/users/:user_id/posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT api/users/:user_id/posts/:id
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE api/users/:user_id/posts/:id
  def destroy
    @post.destroy
  end

  private
    # Callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :text)
    end

    def user
      @user = User.find(params[:user_id])
    end
end
