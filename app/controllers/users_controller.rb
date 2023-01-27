class UsersController < ApplicationController
  def index
    users
    @current_user = current_user
  end

  def show
    @current_user = current_user
    user
  end

  private

  def user
    @user = User.find(params[:id])
  end

  def users
    @users = User.all
  end
end
