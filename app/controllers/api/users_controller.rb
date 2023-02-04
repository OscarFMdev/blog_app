class Api::UsersController < ApplicationController
  # GET /api/users
  def index
    @users = User.all.select('name, id, bio, email')
    render json: @users
  end

  # GET /api/users/1
  def show
    @user = User.select('name, id, bio, email').find(params[:id])
    render json: @user
  end

  # POST /api/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/users/1
  def destroy
    @user.destroy
  end
end
