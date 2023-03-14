class UsersController < ApplicationController
  def index
    @users = User.includes(:posts).order(created_at: :asc)
  end

  def show
    @user = User.includes(:posts, :comments).find_by(id: params[:id])
  end
end
