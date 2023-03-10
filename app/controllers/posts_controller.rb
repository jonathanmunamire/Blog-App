class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find_by(author_id: params[:user_id], id: params[:id])
    @user = User.find(params[:user_id])
  end
end
